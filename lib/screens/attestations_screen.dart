import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:go_router/go_router.dart';
import '../providers/jqr_providers.dart';
import '../widgets/common/time_utils.dart';
import '../services/auth_service.dart';
import '../data/jqr_data.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';

// Provider for JQR attestations using kind 31001 events  
final attestationsProvider = Provider<StorageState<CustomData>>((ref) {
  return ref.watch(
    query<CustomData>(
      tags: {
        '#authority': {'bitcoinveterans.org'},
      },
      limit: 100,
      source: LocalAndRemoteSource(stream: true, background: true),
      and: (attestation) => {
        attestation.author,
      },
    ),
  );
});

// Provider for user's attestations
final userAttestationsProvider = Provider<List<CustomData>>((ref) {
  final userNpub = ref.watch(userNpubProvider);
  final attestationsState = ref.watch(attestationsProvider);
  
  return switch (attestationsState) {
    StorageData(:final models) when userNpub != null => models.where((attestation) {
        // Check if this attestation references the current user
        final pTags = attestation.event.tags.where(
          (tag) => tag.isNotEmpty && tag[0] == 'p' && tag.length > 1
        );
        return pTags.any((tag) => tag[1] == userNpub);
      }).cast<CustomData>().toList(),
    _ => [],
  };
});

// Helper function to extract tag values from CustomData
String? _getTagValue(CustomData attestation, String tagName) {
  final matchingTags = attestation.event.tags.where(
    (tag) => tag.isNotEmpty && tag[0] == tagName && tag.length > 1
  ).toList();
  return matchingTags.isNotEmpty ? matchingTags.first[1] : null;
}

class AttestationsScreen extends ConsumerWidget {
  const AttestationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAttestations = ref.watch(userAttestationsProvider);
    final allAttestationsState = ref.watch(attestationsProvider);
    final userNpub = ref.watch(userNpubProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('JQR Attestations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showAttestationInfo(context),
          ),
        ],
      ),
      body: userNpub == null
          ? _buildUnauthenticatedState(context)
          : DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'My Attestations', icon: Icon(Icons.verified_user)),
                      Tab(text: 'All Attestations', icon: Icon(Icons.public)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildMyAttestationsTab(context, userAttestations),
                        _buildAllAttestationsTab(context, allAttestationsState),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: userNpub != null
          ? FloatingActionButton(
              onPressed: () => _requestAttestation(context, ref),
              child: const Icon(Icons.add),
              tooltip: 'Request Attestation',
            )
          : null,
    );
  }

  Widget _buildUnauthenticatedState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.key_off,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Sign In Required',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Sign in with your Nostr keypair to view and manage your JQR attestations.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go('/auth'),
              icon: const Icon(Icons.key),
              label: const Text('Sign In'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyAttestationsTab(BuildContext context, List<CustomData> attestations) {
    if (attestations.isEmpty) {
      return _buildEmptyAttestationsState(context);
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh attestations
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: attestations.length,
        itemBuilder: (context, index) => AttestationCard(
          attestation: attestations[index],
          isUserAttestation: true,
        ),
      ),
    );
  }

  Widget _buildAllAttestationsTab(BuildContext context, StorageState<CustomData> allAttestationsState) {
    return switch (allAttestationsState) {
      StorageData(:final models) => models.isEmpty
          ? _buildNoPublicAttestationsState(context)
          : RefreshIndicator(
              onRefresh: () async {
                // Refresh all attestations
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: models.length,
                itemBuilder: (context, index) => AttestationCard(
                  attestation: models[index],
                  isUserAttestation: false,
                ),
              ),
            ),
      StorageError(:final exception) => _buildErrorState(context, exception),
      _ => _buildLoadingState(context),
    };
  }

  Widget _buildEmptyAttestationsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.badge,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'No Attestations Yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You haven\'t received any JQR attestations yet. Complete study items and request attestations from verified SMEs.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.go('/study'),
              icon: const Icon(Icons.book),
              label: const Text('Start Studying'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoPublicAttestationsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.public_off,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'No Public Attestations',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'No JQR attestations have been published to the network yet. Be one of the first to earn and share your qualifications!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
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
          Text('Loading attestations...'),
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
              'Failed to Load Attestations',
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

  void _requestAttestation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Attestation'),
        content: const Text(
          'Attestation requests are coming soon! For now, work with a verified SME (Subject Matter Expert) to validate your JQR progress.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAttestationInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About JQR Attestations'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'What are JQR Attestations?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'JQR Attestations are cryptographic signatures from verified Subject Matter Experts (SMEs) confirming that you have successfully demonstrated knowledge or skills for specific Job Qualification Requirements.',
              ),
              SizedBox(height: 16),
              Text(
                'How do they work?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• SMEs review your work or test your knowledge\n'
                '• Upon successful completion, they sign a Nostr event (kind 31001)\n'
                '• The attestation is published to the Nostr network\n'
                '• Your progress is permanently recorded on the decentralized network',
              ),
              SizedBox(height: 16),
              Text(
                'Authority: bitcoinveterans.org',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

class AttestationCard extends ConsumerWidget {
  final CustomData attestation;
  final bool isUserAttestation;

  const AttestationCard({
    super.key,
    required this.attestation,
    required this.isUserAttestation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    // Extract attestation data
    final itemId = _getTagValue(attestation, 'jqr_item');
    final status = _getTagValue(attestation, 'status') ?? 'pending';
    final authorNpub = attestation.pubkey;
    final attestedUser = _getTagValue(attestation, 'p');
    
    // Get JQR item details
    final jqrItem = itemId != null ? JQRData.getItem(itemId) : null;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIcon(context, status),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jqrItem?.title ?? 'JQR Item $itemId',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (jqrItem != null) ...[
                        Text(
                          'Section ${jqrItem.section} • ${_getLevelDisplayName(jqrItem.level)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                _buildStatusChip(context, status),
              ],
            ),
            
            if (jqrItem != null) ...[
              const SizedBox(height: 12),
              Text(
                jqrItem.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // SME and timestamp info
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: theme.colorScheme.primary,
                  child: const Icon(Icons.person, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SME: ${_formatPubkey(authorNpub)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        TimeUtils.formatTimestamp(attestation.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showAttestationDetails(context, attestation, jqrItem),
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'View Details',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context, String status) {
    IconData icon;
    Color color;
    
    switch (status.toLowerCase()) {
      case 'completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'pending':
        icon = Icons.pending;
        color = Colors.orange;
        break;
      case 'rejected':
        icon = Icons.cancel;
        color = Colors.red;
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey;
    }
    
    return Icon(icon, color: color, size: 24);
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Colors.green.withValues(alpha: 0.2);
        textColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = Colors.orange.withValues(alpha: 0.2);
        textColor = Colors.orange;
        break;
      case 'rejected':
        backgroundColor = Colors.red.withValues(alpha: 0.2);
        textColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey.withValues(alpha: 0.2);
        textColor = Colors.grey;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getLevelDisplayName(QualificationLevel level) {
    switch (level) {
      case QualificationLevel.basic:
        return 'Basic';
      case QualificationLevel.journeyman:
        return 'Journeyman';
      case QualificationLevel.advanced:
        return 'Advanced';
      case QualificationLevel.master:
        return 'Master';
    }
  }

  String _formatPubkey(String pubkey) {
    return '${pubkey.substring(0, 8)}...${pubkey.substring(pubkey.length - 8)}';
  }

  void _showAttestationDetails(BuildContext context, CustomData attestation, JQRItem? jqrItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Attestation Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (jqrItem != null) ...[
                Text('Item: ${jqrItem.title}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Description: ${jqrItem.description}'),
                const SizedBox(height: 8),
                Text('Type: ${jqrItem.type.name}'),
                const SizedBox(height: 16),
              ],
              Text('Event ID: ${attestation.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('SME Pubkey: ${attestation.pubkey}'),
              const SizedBox(height: 8),
              Text('Timestamp: ${TimeUtils.formatTimestamp(attestation.createdAt)}'),
              const SizedBox(height: 8),
              Text('Authority: bitcoinveterans.org'),
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
}