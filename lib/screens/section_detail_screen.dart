import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';
import '../providers/jqr_providers.dart';
import '../data/jqr_data.dart';

class SectionDetailScreen extends ConsumerWidget {
  final String sectionId;

  const SectionDetailScreen({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = JQRData.sections[sectionId];
    final userProgress = ref.watch(userProgressProvider);

    if (section == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Section Not Found')),
        body: const Center(
          child: Text('This section does not exist.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Section ${section.id}: ${section.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showSectionInfo(context, section),
          ),
        ],
      ),
      body: Column(
        children: [
          // Section Header
          _buildSectionHeader(context, section, userProgress),
          
          // Items List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: section.items.length,
              itemBuilder: (context, index) {
                final item = section.items[index];
                final attestation = userProgress?.itemAttestations[item.id];
                return _buildItemCard(context, item, attestation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, JQRSection section, UserProgress? userProgress) {
    final completedItems = userProgress?.itemAttestations.values
        .where((a) => a.status == AttestationStatus.completed)
        .where((a) => JQRData.getItem(a.itemId)?.section == section.id)
        .length ?? 0;
    
    final totalItems = section.items.length;
    final progress = totalItems > 0 ? completedItems / totalItems : 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getLevelColor(context, section.level).withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getLevelColor(context, section.level),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    section.id,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _getLevelDisplayName(section.level),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getLevelColor(context, section.level),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Text(
            section.description,
            style: Theme.of(context).textTheme.bodyMedium,
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
        ],
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, JQRItem item, JQRAttestation? attestation) {
    final isCompleted = attestation?.status == AttestationStatus.completed;
    final isPending = attestation?.status == AttestationStatus.pendingSignature;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showItemDetail(context, item, attestation),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Status Icon
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: _getStatusColor(isCompleted, isPending).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getStatusIcon(isCompleted, isPending),
                      size: 18,
                      color: _getStatusColor(isCompleted, isPending),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Item Number and Type
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Item ${item.id}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getTypeColor(item.type).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getTypeDisplayName(item.type),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: _getTypeColor(item.type),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
              
              const SizedBox(height: 12),
              
              // Title
              Text(
                item.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Description (truncated)
              Text(
                item.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              // Prerequisites if any
              if (item.prerequisites.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Prerequisites: ${item.prerequisites.join(', ')}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
        return 'Basic Level';
      case QualificationLevel.journeyman:
        return 'Journeyman Level';
      case QualificationLevel.advanced:
        return 'Advanced Level';
      case QualificationLevel.master:
        return 'Master Level';
    }
  }

  Color _getStatusColor(bool isCompleted, bool isPending) {
    if (isCompleted) return Colors.green;
    if (isPending) return Colors.orange;
    return Colors.grey;
  }

  IconData _getStatusIcon(bool isCompleted, bool isPending) {
    if (isCompleted) return Icons.check_circle;
    if (isPending) return Icons.pending;
    return Icons.radio_button_unchecked;
  }

  Color _getTypeColor(RequirementType type) {
    switch (type) {
      case RequirementType.memorization:
        return Colors.blue;
      case RequirementType.demonstration:
        return Colors.green;
      case RequirementType.practical:
        return Colors.orange;
      case RequirementType.leadership:
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

  void _showSectionInfo(BuildContext context, JQRSection section) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Section ${section.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              section.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(section.description),
            const SizedBox(height: 16),
            Text(
              'Level: ${_getLevelDisplayName(section.level)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text('Items: ${section.items.length}'),
          ],
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

  void _showItemDetail(BuildContext context, JQRItem item, JQRAttestation? attestation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Item ${item.id}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              
              Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(item.description),
              
              const SizedBox(height: 16),
              
              Text(
                'Type: ${_getTypeDisplayName(item.type)}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              
              if (item.prerequisites.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Prerequisites: ${item.prerequisites.join(', ')}',
                  style: TextStyle(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              
              if (item.studyMaterials.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'Study Materials',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                ...item.studyMaterials.map((material) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text('• $material'),
                )),
              ],
              
              if (attestation != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(
                        attestation.status == AttestationStatus.completed,
                        attestation.status == AttestationStatus.pendingSignature,
                      ),
                      size: 16,
                      color: _getStatusColor(
                        attestation.status == AttestationStatus.completed,
                        attestation.status == AttestationStatus.pendingSignature,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(attestation.status.name.toUpperCase()),
                  ],
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          if (attestation?.status != AttestationStatus.completed)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestAttestation(context, item);
              },
              child: const Text('Request Signature'),
            ),
        ],
      ),
    );
  }

  void _requestAttestation(BuildContext context, JQRItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attestation request for Item ${item.id} - Coming soon!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}