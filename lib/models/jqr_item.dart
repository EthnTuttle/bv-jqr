import 'package:freezed_annotation/freezed_annotation.dart';

part 'jqr_item.freezed.dart';
part 'jqr_item.g.dart';

enum RequirementType {
  memorization,
  demonstration,
  practical,
  leadership,
}

enum QualificationLevel {
  basic,
  journeyman, 
  advanced,
  master,
}

@freezed
class JQRItem with _$JQRItem {
  const factory JQRItem({
    required String id, // e.g., "101.1"
    required String section, // e.g., "100"
    required String title,
    required String description,
    required List<String> studyMaterials,
    required RequirementType type,
    required QualificationLevel level,
    @Default([]) List<String> prerequisites,
    String? notes,
  }) = _JQRItem;

  factory JQRItem.fromJson(Map<String, dynamic> json) => _$JQRItemFromJson(json);
}

@freezed 
class JQRSection with _$JQRSection {
  const factory JQRSection({
    required String id, // e.g., "100"
    required String title,
    required String description,
    required List<JQRItem> items,
    required QualificationLevel level,
  }) = _JQRSection;

  factory JQRSection.fromJson(Map<String, dynamic> json) => _$JQRSectionFromJson(json);
}