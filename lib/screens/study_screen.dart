import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/jqr_providers.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';
import '../data/jqr_data.dart';

class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jqrSections = ref.watch(jqrSectionsProvider);
    final userProgress = ref.watch(userProgressProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('JQR Study Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jqrSections.length,
        itemBuilder: (context, index) {
          final section = jqrSections[index];
          final completedItems = userProgress?.itemAttestations.values
              .where((a) => a.status == AttestationStatus.completed)
              .where((a) => JQRData.getItem(a.itemId)?.section == section.id)
              .length ?? 0;
          
          return _buildSectionCard(context, section, completedItems);
        },
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, JQRSection section, int completedItems) {
    final totalItems = section.items.length;
    final progress = totalItems > 0 ? completedItems / totalItems : 0.0;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/study/section/${section.id}'),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getLevelColor(context, section.level).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        section.id,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getLevelColor(context, section.level),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          section.description,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '$completedItems/$totalItems items',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(
                      _getLevelColor(context, section.level),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Level Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getLevelColor(context, section.level).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getLevelDisplayName(section.level),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _getLevelColor(context, section.level),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
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
        return 'Basic';
      case QualificationLevel.journeyman:
        return 'Journeyman';
      case QualificationLevel.advanced:
        return 'Advanced';
      case QualificationLevel.master:
        return 'Master';
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search JQR Items'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Enter keywords to search...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement search functionality
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}