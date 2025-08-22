import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../providers/jqr_providers.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';
import '../widgets/common/time_utils.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProgress = ref.watch(userProgressProvider);
    final progressStats = ref.watch(progressStatsProvider);
    final userNpub = ref.watch(userNpubProvider);

    if (userProgress == null || userNpub == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Loading your JQR progress...',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    final progressPercentage = progressStats['progressPercentage'] as double;
    final currentLevel = progressStats['currentLevel'] as QualificationLevel;
    final completedItems = progressStats['completedItems'] as int;
    final totalItems = progressStats['totalItems'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('JQR Progress'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            _buildWelcomeHeader(context, userNpub, currentLevel),
            const SizedBox(height: 24),
            
            // Overall Progress
            _buildProgressOverview(context, progressPercentage, completedItems, totalItems),
            const SizedBox(height: 24),
            
            // Qualification Level Progress
            _buildQualificationProgress(context, currentLevel, progressStats['sectionProgress'] as Map<String, int>),
            const SizedBox(height: 24),
            
            // Quick Actions
            _buildQuickActions(context),
            const SizedBox(height: 24),
            
            // Recent Activity
            _buildRecentActivity(context, userProgress),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, String npub, QualificationLevel level) {
    final shortNpub = '${npub.substring(0, 8)}...${npub.substring(npub.length - 8)}';
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Icon(
                Icons.military_tech,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    shortNpub,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _getLevelColor(context, level).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getLevelDisplayName(level),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: _getLevelColor(context, level),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressOverview(BuildContext context, double percentage, int completed, int total) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Progress',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            CircularPercentIndicator(
              radius: 60,
              lineWidth: 8,
              percent: percentage,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(percentage * 100).toInt()}%',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Complete',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
              progressColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            ),
            
            const SizedBox(height: 16),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn(context, 'Completed', '$completed'),
                _buildStatColumn(context, 'Remaining', '${total - completed}'),
                _buildStatColumn(context, 'Total Items', '$total'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildQualificationProgress(BuildContext context, QualificationLevel currentLevel, Map<String, int> sectionProgress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Qualification Levels',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            ...QualificationLevel.values.map((level) {
              final isCurrentOrCompleted = level.index <= currentLevel.index;
              final sectionId = (level.index + 1) * 100;
              final completed = sectionProgress['$sectionId'] ?? 0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      isCurrentOrCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: isCurrentOrCompleted 
                        ? _getLevelColor(context, level)
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getLevelDisplayName(level),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isCurrentOrCompleted 
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                          Text(
                            'Section ${sectionId ~/ 100}00 • $completed items completed',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.book,
                title: 'Study Guide',
                subtitle: 'Browse JQR items',
                onTap: () => context.push('/study'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.forum,
                title: 'Community',
                subtitle: 'Join discussions',
                onTap: () => context.push('/community'),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.verified_user,
                title: 'Attestations',
                subtitle: 'View signatures',
                onTap: () => context.push('/attestations'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                icon: Icons.analytics,
                title: 'Analytics',
                subtitle: 'Track metrics',
                onTap: () => context.push('/analytics'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, userProgress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            if (userProgress.itemAttestations.isEmpty)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.assignment_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No activity yet',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      'Start studying to track your progress',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...userProgress.itemAttestations.values.take(5).map((attestation) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: Text('Item ${attestation.itemId}'),
                  subtitle: Text(TimeUtils.formatTimestamp(attestation.timestamp)),
                  trailing: Icon(
                    attestation.status == AttestationStatus.completed
                      ? Icons.check_circle
                      : Icons.pending,
                    color: attestation.status == AttestationStatus.completed
                      ? Colors.green
                      : Colors.orange,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(BuildContext context, QualificationLevel level) {
    switch (level) {
      case QualificationLevel.basic:
        return Colors.blue;
      case QualificationLevel.journeyman:
        return Colors.green;
      case QualificationLevel.advanced:
        return Colors.orange;
      case QualificationLevel.master:
        return Colors.purple;
    }
  }

  String _getLevelDisplayName(QualificationLevel level) {
    switch (level) {
      case QualificationLevel.basic:
        return 'Basic Qualified';
      case QualificationLevel.journeyman:
        return 'Journeyman';
      case QualificationLevel.advanced:
        return 'Advanced';
      case QualificationLevel.master:
        return 'Master';
    }
  }
}