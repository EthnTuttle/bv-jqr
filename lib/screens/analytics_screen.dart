import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:go_router/go_router.dart';
import '../providers/jqr_providers.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';
import '../data/jqr_data.dart';
import '../widgets/common/time_utils.dart';

// Provider for analytics data
final analyticsProvider = Provider<Map<String, dynamic>>((ref) {
  final userProgress = ref.watch(userProgressProvider);
  final progressStats = ref.watch(progressStatsProvider);
  
  if (userProgress == null) {
    return <String, dynamic>{};
  }

  // Calculate advanced analytics
  final completedAttestations = userProgress.itemAttestations.values
      .where((a) => a.status == AttestationStatus.completed)
      .toList();

  final pendingAttestations = userProgress.itemAttestations.values
      .where((a) => a.status == AttestationStatus.pendingSignature)
      .toList();

  // Note: There's no 'rejected' status in the current model, using inProgress as fallback
  final inProgressAttestations = userProgress.itemAttestations.values
      .where((a) => a.status == AttestationStatus.inProgress)
      .toList();

  // Calculate progress by level
  final levelProgress = <QualificationLevel, Map<String, int>>{};
  for (final level in QualificationLevel.values) {
    final levelItems = JQRData.getItemsForLevel(level);
    final completedLevelItems = levelItems.where((item) => 
        completedAttestations.any((att) => att.itemId == item.id)).toList();
    
    levelProgress[level] = {
      'completed': completedLevelItems.length,
      'total': levelItems.length,
    };
  }

  // Calculate progress by type
  final typeProgress = <RequirementType, Map<String, int>>{};
  for (final type in RequirementType.values) {
    final typeItems = JQRData.allItems.where((item) => item.type == type).toList();
    final completedTypeItems = typeItems.where((item) => 
        completedAttestations.any((att) => att.itemId == item.id)).toList();
    
    typeProgress[type] = {
      'completed': completedTypeItems.length,
      'total': typeItems.length,
    };
  }

  // Calculate recent activity (last 30 days)
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
  final recentCompletions = completedAttestations.where((att) => 
      att.timestamp.isAfter(thirtyDaysAgo)).length;

  // Calculate velocity (average completions per week over last 30 days)
  final velocity = recentCompletions / 4.0; // 30 days ≈ 4 weeks

  // Calculate estimated completion time
  final remaining = (progressStats['totalItems'] as int) - (progressStats['completedItems'] as int);
  final estimatedWeeksToComplete = velocity > 0 ? remaining / velocity : double.infinity;

  return {
    'levelProgress': levelProgress,
    'typeProgress': typeProgress,
    'recentCompletions': recentCompletions,
    'velocity': velocity,
    'estimatedWeeksToComplete': estimatedWeeksToComplete,
    'totalCompleted': completedAttestations.length,
    'totalPending': pendingAttestations.length,
    'totalInProgress': inProgressAttestations.length,
    'completionsByMonth': _calculateCompletionsByMonth(completedAttestations),
  };
});

List<Map<String, dynamic>> _calculateCompletionsByMonth(List<JQRAttestation> attestations) {
  final monthlyData = <String, int>{};
  
  for (final attestation in attestations) {
    final monthKey = '${attestation.timestamp.year}-${attestation.timestamp.month.toString().padLeft(2, '0')}';
    monthlyData[monthKey] = (monthlyData[monthKey] ?? 0) + 1;
  }

  // Get last 6 months
  final now = DateTime.now();
  final months = <Map<String, dynamic>>[];
  
  for (int i = 5; i >= 0; i--) {
    final month = DateTime(now.year, now.month - i, 1);
    final monthKey = '${month.year}-${month.month.toString().padLeft(2, '0')}';
    final monthName = _getMonthName(month.month);
    
    months.add({
      'month': monthName,
      'completions': monthlyData[monthKey] ?? 0,
    });
  }

  return months;
}

String _getMonthName(int month) {
  const months = [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return months[month];
}

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNpub = ref.watch(userNpubProvider);
    final analytics = ref.watch(analyticsProvider);
    final progressStats = ref.watch(progressStatsProvider);

    if (userNpub == null) {
      return _buildUnauthenticatedState(context);
    }

    if (analytics.isEmpty) {
      return _buildEmptyState(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(analyticsProvider),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCards(context, analytics, progressStats),
            const SizedBox(height: 24),
            _buildProgressByLevel(context, analytics['levelProgress']),
            const SizedBox(height: 24),
            _buildProgressByType(context, analytics['typeProgress']),
            const SizedBox(height: 24),
            _buildVelocityCard(context, analytics),
            const SizedBox(height: 24),
            _buildMonthlyProgress(context, analytics['completionsByMonth']),
          ],
        ),
      ),
    );
  }

  Widget _buildUnauthenticatedState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.analytics,
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
                'Sign in to view your JQR progress analytics and insights.',
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
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart,
                size: 80,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 24),
              Text(
                'No Progress Data',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Start completing JQR items to see detailed analytics about your progress.',
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
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context, Map<String, dynamic> analytics, Map<String, dynamic> progressStats) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                context,
                'Total Completed',
                '${analytics['totalCompleted']}',
                Icons.check_circle,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOverviewCard(
                context,
                'Pending',
                '${analytics['totalPending']}',
                Icons.pending,
                Colors.orange,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                context,
                'Current Level',
                _getLevelDisplayName(progressStats['currentLevel']),
                Icons.military_tech,
                theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildOverviewCard(
                context,
                'Progress',
                '${((progressStats['progressPercentage'] as double) * 100).toInt()}%',
                Icons.trending_up,
                theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressByLevel(BuildContext context, Map<QualificationLevel, Map<String, int>> levelProgress) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress by Qualification Level',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            ...levelProgress.entries.map((entry) {
              final level = entry.key;
              final stats = entry.value;
              final completed = stats['completed'] ?? 0;
              final total = stats['total'] ?? 0;
              final percentage = total > 0 ? completed / total : 0.0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getLevelDisplayName(level),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$completed/$total',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(
                        _getLevelColor(level),
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

  Widget _buildProgressByType(BuildContext context, Map<RequirementType, Map<String, int>> typeProgress) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progress by Requirement Type',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            ...typeProgress.entries.map((entry) {
              final type = entry.key;
              final stats = entry.value;
              final completed = stats['completed'] ?? 0;
              final total = stats['total'] ?? 0;
              final percentage = total > 0 ? completed / total : 0.0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getTypeIcon(type),
                              size: 20,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _getTypeDisplayName(type),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '$completed/$total',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: percentage,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(
                        theme.colorScheme.primary,
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

  Widget _buildVelocityCard(BuildContext context, Map<String, dynamic> analytics) {
    final theme = Theme.of(context);
    final velocity = analytics['velocity'] as double;
    final estimatedWeeks = analytics['estimatedWeeksToComplete'] as double;
    final recentCompletions = analytics['recentCompletions'] as int;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Velocity',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        recentCompletions.toString(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Last 30 Days',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        velocity.toStringAsFixed(1),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Text(
                        'Per Week',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        estimatedWeeks.isFinite 
                            ? '${estimatedWeeks.ceil()}w'
                            : '∞',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'To Complete',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyProgress(BuildContext context, List<Map<String, dynamic>> monthlyData) {
    final theme = Theme.of(context);
    final maxCompletions = monthlyData.map((m) => m['completions'] as int).reduce((a, b) => a > b ? a : b);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Progress',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: monthlyData.map((monthData) {
                  final completions = monthData['completions'] as int;
                  final month = monthData['month'] as String;
                  final height = maxCompletions > 0 
                      ? (completions / maxCompletions) * 80 
                      : 0.0;
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (completions > 0)
                        Text(
                          completions.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Container(
                        width: 24,
                        height: height < 8 && completions > 0 ? 8 : height,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        month,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
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

  Color _getLevelColor(QualificationLevel level) {
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

  String _getTypeDisplayName(RequirementType type) {
    switch (type) {
      case RequirementType.memorization:
        return 'Memorization';
      case RequirementType.demonstration:
        return 'Demonstration';
      case RequirementType.practical:
        return 'Practical';
      case RequirementType.leadership:
        return 'Leadership';
    }
  }

  IconData _getTypeIcon(RequirementType type) {
    switch (type) {
      case RequirementType.memorization:
        return Icons.psychology;
      case RequirementType.demonstration:
        return Icons.quiz;
      case RequirementType.practical:
        return Icons.build;
      case RequirementType.leadership:
        return Icons.groups;
    }
  }
}