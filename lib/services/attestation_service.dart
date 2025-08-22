import '../models/user_progress.dart';

class AttestationService {
  /// Custom event kind for BV-JQR attestations
  static const int jqrAttestationKind = 31001;

  /// Create an offline attestation for later publishing
  static JQRAttestation createOfflineAttestation({
    required String itemId,
    required String candidateNpub,
    required String smeNpub,
    String? notes,
  }) {
    return JQRAttestation(
      itemId: itemId,
      candidateNpub: candidateNpub,
      smeNpub: smeNpub,
      timestamp: DateTime.now(),
      notes: notes,
      status: AttestationStatus.pendingSignature,
      isOffline: true,
    );
  }

  /// Validate that an SME is authorized for a specific authority
  static bool isAuthorizedSME(String smeNpub, String authority) {
    // TODO: Implement NIP-05 verification for the authority domain
    // For now, return true for development
    return true;
  }

  /// Create a mock attestation for testing
  static JQRAttestation createMockAttestation({
    required String itemId,
    required String candidateNpub,
    String? notes,
  }) {
    return JQRAttestation(
      itemId: itemId,
      candidateNpub: candidateNpub,
      smeNpub: 'npub1mocksmexample123456789abcdefghijklmnopqrstuvwxyz',
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      notes: notes ?? 'Mock attestation for development',
      status: AttestationStatus.completed,
      isOffline: false,
    );
  }
}