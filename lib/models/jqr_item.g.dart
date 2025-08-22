// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jqr_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JQRItemImpl _$$JQRItemImplFromJson(Map<String, dynamic> json) =>
    _$JQRItemImpl(
      id: json['id'] as String,
      section: json['section'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      studyMaterials: (json['studyMaterials'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$RequirementTypeEnumMap, json['type']),
      level: $enumDecode(_$QualificationLevelEnumMap, json['level']),
      prerequisites:
          (json['prerequisites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$JQRItemImplToJson(_$JQRItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'section': instance.section,
      'title': instance.title,
      'description': instance.description,
      'studyMaterials': instance.studyMaterials,
      'type': _$RequirementTypeEnumMap[instance.type]!,
      'level': _$QualificationLevelEnumMap[instance.level]!,
      'prerequisites': instance.prerequisites,
      'notes': instance.notes,
    };

const _$RequirementTypeEnumMap = {
  RequirementType.memorization: 'memorization',
  RequirementType.demonstration: 'demonstration',
  RequirementType.practical: 'practical',
  RequirementType.leadership: 'leadership',
};

const _$QualificationLevelEnumMap = {
  QualificationLevel.basic: 'basic',
  QualificationLevel.journeyman: 'journeyman',
  QualificationLevel.advanced: 'advanced',
  QualificationLevel.master: 'master',
};

_$JQRSectionImpl _$$JQRSectionImplFromJson(Map<String, dynamic> json) =>
    _$JQRSectionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => JQRItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: $enumDecode(_$QualificationLevelEnumMap, json['level']),
    );

Map<String, dynamic> _$$JQRSectionImplToJson(_$JQRSectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'items': instance.items,
      'level': _$QualificationLevelEnumMap[instance.level]!,
    };
