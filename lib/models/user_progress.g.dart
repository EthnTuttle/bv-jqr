// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JQRAttestationImpl _$$JQRAttestationImplFromJson(Map<String, dynamic> json) =>
    _$JQRAttestationImpl(
      itemId: json['itemId'] as String,
      candidateNpub: json['candidateNpub'] as String,
      smeNpub: json['smeNpub'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String?,
      nostrEventId: json['nostrEventId'] as String?,
      status:
          $enumDecodeNullable(_$AttestationStatusEnumMap, json['status']) ??
          AttestationStatus.notStarted,
      isOffline: json['isOffline'] as bool?,
    );

Map<String, dynamic> _$$JQRAttestationImplToJson(
  _$JQRAttestationImpl instance,
) => <String, dynamic>{
  'itemId': instance.itemId,
  'candidateNpub': instance.candidateNpub,
  'smeNpub': instance.smeNpub,
  'timestamp': instance.timestamp.toIso8601String(),
  'notes': instance.notes,
  'nostrEventId': instance.nostrEventId,
  'status': _$AttestationStatusEnumMap[instance.status]!,
  'isOffline': instance.isOffline,
};

const _$AttestationStatusEnumMap = {
  AttestationStatus.notStarted: 'notStarted',
  AttestationStatus.inProgress: 'inProgress',
  AttestationStatus.pendingSignature: 'pendingSignature',
  AttestationStatus.completed: 'completed',
};

_$UserProgressImpl _$$UserProgressImplFromJson(Map<String, dynamic> json) =>
    _$UserProgressImpl(
      npub: json['npub'] as String,
      selectedAuthority: json['selectedAuthority'] as String,
      itemAttestations:
          (json['itemAttestations'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, JQRAttestation.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      currentLevel:
          $enumDecodeNullable(
            _$QualificationLevelEnumMap,
            json['currentLevel'],
          ) ??
          QualificationLevel.basic,
      totalItemsCompleted: (json['totalItemsCompleted'] as num?)?.toInt() ?? 0,
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserProgressImplToJson(_$UserProgressImpl instance) =>
    <String, dynamic>{
      'npub': instance.npub,
      'selectedAuthority': instance.selectedAuthority,
      'itemAttestations': instance.itemAttestations,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'currentLevel': _$QualificationLevelEnumMap[instance.currentLevel]!,
      'totalItemsCompleted': instance.totalItemsCompleted,
      'totalItems': instance.totalItems,
    };

const _$QualificationLevelEnumMap = {
  QualificationLevel.basic: 'basic',
  QualificationLevel.journeyman: 'journeyman',
  QualificationLevel.advanced: 'advanced',
  QualificationLevel.master: 'master',
};

_$JQRAuthorityImpl _$$JQRAuthorityImplFromJson(Map<String, dynamic> json) =>
    _$JQRAuthorityImpl(
      nip05Domain: json['nip05Domain'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      authorizedSMEs: (json['authorizedSMEs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$JQRAuthorityImplToJson(_$JQRAuthorityImpl instance) =>
    <String, dynamic>{
      'nip05Domain': instance.nip05Domain,
      'name': instance.name,
      'description': instance.description,
      'authorizedSMEs': instance.authorizedSMEs,
      'isActive': instance.isActive,
    };
