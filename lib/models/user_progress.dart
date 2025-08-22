import 'package:freezed_annotation/freezed_annotation.dart';
import 'jqr_item.dart';

part 'user_progress.freezed.dart';
part 'user_progress.g.dart';

enum AttestationStatus {
  notStarted,
  inProgress,
  pendingSignature,
  completed,
}

@freezed
class JQRAttestation with _$JQRAttestation {
  const factory JQRAttestation({
    required String itemId,
    required String candidateNpub,
    required String smeNpub,
    required DateTime timestamp,
    String? notes,
    String? nostrEventId,
    @Default(AttestationStatus.notStarted) AttestationStatus status,
    bool? isOffline, // For field operations
  }) = _JQRAttestation;

  factory JQRAttestation.fromJson(Map<String, dynamic> json) => _$JQRAttestationFromJson(json);
}

@freezed
class UserProgress with _$UserProgress {
  const factory UserProgress({
    required String npub,
    required String selectedAuthority, // NIP-05 domain
    @Default({}) Map<String, JQRAttestation> itemAttestations,
    required DateTime lastUpdated,
    @Default(QualificationLevel.basic) QualificationLevel currentLevel,
    @Default(0) int totalItemsCompleted,
    @Default(0) int totalItems,
  }) = _UserProgress;

  factory UserProgress.fromJson(Map<String, dynamic> json) => _$UserProgressFromJson(json);
}

@freezed
class JQRAuthority with _$JQRAuthority {
  const factory JQRAuthority({
    required String nip05Domain, // e.g., "bitcoinveterans.org"
    required String name,
    required String description,
    required List<String> authorizedSMEs, // List of npubs
    @Default(true) bool isActive,
  }) = _JQRAuthority;

  factory JQRAuthority.fromJson(Map<String, dynamic> json) => _$JQRAuthorityFromJson(json);
}