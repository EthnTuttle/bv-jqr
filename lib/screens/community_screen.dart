import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:go_router/go_router.dart';
import '../providers/jqr_providers.dart';
import '../widgets/common/note_parser.dart';
import '../widgets/common/time_utils.dart';
import '../services/auth_service.dart';
import '../utils/extensions.dart';

// Provider for verified BV-JQR authority members
final bvJqrAuthorityProvider = Provider<Set<String>>((ref) {
  // Known BV-JQR authority pubkeys (SMEs and verified members)
  // In production, this would be fetched from NIP-05 verification or authority lists
  return {
    // Add known authority pubkeys here
    // These would be populated from bitcoinveterans.org NIP-05 verification
    // or from a decentralized authority registry
  };
});

// Simplified BV-JQR hashtag strategy - only core tags
final bvJqrHashtagsProvider = Provider<Set<String>>((ref) {
  return {
    'bvjqr',           // Primary BV-JQR tag
    'bitcoinveterans', // Organization tag
  };
});

// Provider for BV-JQR focused community notes
final communityNotesProvider = Provider<StorageState<Note>>((ref) {
  final bvjqrTags = ref.watch(bvJqrHashtagsProvider);
  
  return ref.watch(
    query<Note>(
      tags: {
        // BV-JQR hashtags from comprehensive strategy
        '#t': bvjqrTags,
        // Authority-related tags
        '#authority': {'bitcoinveterans.org'},
      },
      limit: 100,
      source: LocalAndRemoteSource(stream: true, background: true),
      and: (note) => {
        note.author,      // Load author profiles
        note.reactions,   // Load likes  
        note.zaps,        // Load zaps
      },
    ),
  );
});

// Provider for filtered notes (authority + community)
final filteredCommunityNotesProvider = Provider<List<Note>>((ref) {
  final notesState = ref.watch(communityNotesProvider);
  final authorityMembers = ref.watch(bvJqrAuthorityProvider);
  
  return switch (notesState) {
    StorageData(:final models) => models.where((note) {
        // Include notes from verified authority members
        if (authorityMembers.contains(note.pubkey)) {
          return true;
        }
        
        // Include notes that reference BV-JQR content or authority
        final content = note.content.toLowerCase();
        final bvJqrKeywords = [
          'bv-jqr', 'bvjqr', 'bitcoin veterans', 'bitcoinveterans.org'
        ];
        
        // Check if note content contains relevant keywords
        if (bvJqrKeywords.any((keyword) => content.contains(keyword))) {
          return true;
        }
        
        // Include notes that tag/mention authority members
        if (authorityMembers.any((authorityPubkey) => 
            note.content.contains(authorityPubkey))) {
          return true;
        }
        
        return false;
      }).toList(),
    _ => [],
  };
});

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredNotes = ref.watch(filteredCommunityNotesProvider);
    final authorityMembers = ref.watch(bvJqrAuthorityProvider);
    final userNpub = ref.watch(userNpubProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('BV-JQR Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showCommunityInfo(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(communityNotesProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          // Show membership status banner
          if (userNpub != null) _buildMembershipBanner(context, userNpub, authorityMembers),
          
          Expanded(
            child: filteredNotes.isEmpty
                ? _buildEmptyState(context, ref)
                : RefreshIndicator(
                    onRefresh: () async => ref.refresh(communityNotesProvider),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) => NoteCard(
                        note: filteredNotes[index],
                        onProfileTap: (pubkey) => _navigateToProfile(context, pubkey),
                        onHashtagTap: (hashtag) => _searchHashtag(context, hashtag),
                        onReply: (note) => _composeReply(context, ref, note),
                        isFromAuthority: authorityMembers.contains(filteredNotes[index].pubkey),
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _composeNote(context, ref),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to BV-JQR Community',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Share your Bitcoin journey, discuss JQR topics, and connect with fellow veterans.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            
            // Core hashtag suggestions
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildHashtagChip(context, 'bvjqr'),
                _buildHashtagChip(context, 'bitcoinveterans'),
              ],
            ),
            
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _composeNote(context, ref),
              icon: const Icon(Icons.edit),
              label: const Text('Share Your First Note'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipBanner(BuildContext context, String userNpub, Set<String> authorityMembers) {
    final isAuthority = authorityMembers.contains(userNpub);
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAuthority 
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAuthority 
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isAuthority ? Icons.verified : Icons.group,
            color: isAuthority 
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAuthority 
                      ? 'BV-JQR Authority Member' 
                      : 'Community Participant',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isAuthority 
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onSecondaryContainer,
                  ),
                ),
                Text(
                  isAuthority 
                      ? 'Verified SME • Can issue attestations'
                      : 'Join the JQR journey • Contribute to discussions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isAuthority 
                        ? theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                        : theme.colorScheme.onSecondaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          if (!isAuthority)
            TextButton(
              onPressed: () => _showMembershipInfo(context),
              child: Text(
                'Learn More',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHashtagChip(BuildContext context, String hashtag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        '#$hashtag',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading community discussions...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to Load Community',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to connect to Nostr relays. Check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Check Settings'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProfile(BuildContext context, String pubkey) {
    // TODO: Navigate to profile screen with pubkey
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile view for $pubkey')),
    );
  }

  void _searchHashtag(BuildContext context, String hashtag) {
    // TODO: Navigate to hashtag search
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Searching for #$hashtag')),
    );
  }

  void _composeReply(BuildContext context, WidgetRef ref, Note parentNote) {
    final signer = ref.read(userSignerProvider);
    if (!AuthService.isValidSigner(signer)) {
      _showAuthRequiredDialog(context);
      return;
    }
    
    // TODO: Navigate to compose reply screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reply composer coming soon!')),
    );
  }

  void _composeNote(BuildContext context, WidgetRef ref) {
    final signer = ref.read(userSignerProvider);
    if (!AuthService.isValidSigner(signer)) {
      _showAuthRequiredDialog(context);
      return;
    }
    
    // TODO: Navigate to compose note screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note composer coming soon!')),
    );
  }

  void _showCommunityInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('About BV-JQR Community'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to the Bitcoin Veterans Job Qualification Requirements community!',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'What is BV-JQR?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'BV-JQR is a decentralized system for tracking professional competencies in Bitcoin and freedom technology. Veterans and community members can earn attestations for their skills and knowledge.',
              ),
              const SizedBox(height: 16),
              Text(
                'Community Guidelines',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Respectful discussion of Bitcoin and JQR topics\n'
                '• Share knowledge and help others learn\n'
                '• Authority members (verified SMEs) can issue attestations\n'
                '• All members can contribute to discussions and learning',
              ),
              const SizedBox(height: 16),
              Text(
                'Core Principles',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Professional Bitcoin education and skill development\n'
                '• Veteran community support and networking\n'
                '• Competency-based attestation system\n'
                '• Open source collaboration and learning',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMembershipInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 8),
            const Text('Membership Information'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Two types of community participation:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              
              // Authority Members
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Authority Members',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Verified Subject Matter Experts (SMEs)\n'
                      '• Have NIP-05 verification through bitcoinveterans.org\n'
                      '• Can issue official JQR attestations\n'
                      '• Lead community discussions and education',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Community Participants
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Community Participants',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Any Nostr user can participate\n'
                      '• No NIP-05 verification required\n'
                      '• Can contribute to discussions and learning\n'
                      '• Can receive attestations from authority members\n'
                      '• Can build reputation through community engagement',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              Text(
                'How to Get Started:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '1. Sign in with your Nostr keypair\n'
                '2. Share relevant content using BV-JQR hashtags\n'
                '3. Engage with authority members and the community\n'
                '4. Learn about Bitcoin and freedom technology\n'
                '5. Build your reputation and earn attestations',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got It'),
          ),
        ],
      ),
    );
  }

  void _showAuthRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Authentication Required'),
        content: const Text(
          'You need to sign in with your Nostr keypair to participate in community discussions.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/auth');
            },
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

class NoteCard extends ConsumerWidget {
  final Note note;
  final void Function(String pubkey)? onProfileTap;
  final void Function(String hashtag)? onHashtagTap;
  final void Function(Note note)? onReply;
  final bool isFromAuthority;

  const NoteCard({
    super.key,
    required this.note,
    this.onProfileTap,
    this.onHashtagTap,
    this.onReply,
    this.isFromAuthority = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorPair = [theme.colorScheme.primary, theme.colorScheme.secondary];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author header
            GestureDetector(
              onTap: onProfileTap != null ? () => onProfileTap!(note.pubkey) : null,
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: theme.colorScheme.primary,
                        child: note.author.value?.pictureUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  note.author.value!.pictureUrl!,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => 
                                      Icon(Icons.person, color: theme.colorScheme.onPrimary),
                                ),
                              )
                            : Icon(Icons.person, color: theme.colorScheme.onPrimary),
                      ),
                      // Authority badge
                      if (isFromAuthority)
                        Positioned(
                          right: -2,
                          bottom: -2,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.verified,
                              size: 10,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                note.author.value?.name ?? 
                                '${note.pubkey.substring(0, 8)}...',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (isFromAuthority)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  'SME',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Text(
                          TimeUtils.formatTimestamp(note.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Note content with parsed entities
            ParsedContentWidget(
              note: note,
              colorPair: colorPair,
              onProfileTap: onProfileTap,
              onHashtagTap: onHashtagTap,
            ),
            const SizedBox(height: 16),

            // Engagement row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildEngagementButton(
                  context,
                  Icons.favorite_outline,
                  '${note.reactions.length}',
                  () => _handleLike(context, ref, note),
                ),
                _buildEngagementButton(
                  context,
                  Icons.repeat,
                  '${note.reposts.length}',
                  () => _handleRepost(context, ref, note),
                ),
                _buildEngagementButton(
                  context,
                  Icons.bolt,
                  '${note.zaps.length}',
                  () => _handleZap(context, ref, note),
                ),
                _buildEngagementButton(
                  context,
                  Icons.reply,
                  'Reply',
                  onReply != null ? () => onReply!(note) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            if (label.isNotEmpty && label != '0') ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _handleLike(BuildContext context, WidgetRef ref, Note note) async {
    final signer = ref.read(userSignerProvider);
    if (!AuthService.isValidSigner(signer)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in to like notes')),
      );
      return;
    }

    try {
      final reaction = PartialReaction(
        content: '❤️',
        reactedOn: note,
        reactedOnAuthor: note.author.value,
      );
      await ref.storage.save({reaction as Model});
      await ref.storage.publish({reaction as Model});
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Liked!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to like: $e')),
        );
      }
    }
  }

  Future<void> _handleRepost(BuildContext context, WidgetRef ref, Note note) async {
    final signer = ref.read(userSignerProvider);
    if (!AuthService.isValidSigner(signer)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in to repost notes')),
      );
      return;
    }

    try {
      final repost = PartialRepost(
        repostedNote: note,
        repostedNoteAuthor: note.author.value,
      );
      await ref.storage.save({repost as Model});
      await ref.storage.publish({repost as Model});
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reposted!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to repost: $e')),
        );
      }
    }
  }

  Future<void> _handleZap(BuildContext context, WidgetRef ref, Note note) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lightning zaps coming soon!')),
    );
  }
}