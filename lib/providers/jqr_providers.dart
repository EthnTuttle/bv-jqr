import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amber_signer/amber_signer.dart';
import '../models/jqr_item.dart';
import '../models/user_progress.dart';
import '../data/jqr_data.dart';
import '../services/auth_service.dart';

// JQR Data Providers
final jqrSectionsProvider = Provider<List<JQRSection>>((ref) {
  return JQRData.allSections;
});

final jqrItemsProvider = Provider<List<JQRItem>>((ref) {
  return JQRData.allItems;
});

final jqrItemProvider = Provider.family<JQRItem?, String>((ref, itemId) {
  return JQRData.getItem(itemId);
});

// User Authentication with signer (AmberSigner or test data)
final userSignerProvider = StateProvider<dynamic>((ref) => null);

final userNpubProvider = Provider<String?>((ref) {
  final signer = ref.watch(userSignerProvider);
  return AuthService.extractNpub(signer);
});

final isAmberSignedInProvider = Provider<bool>((ref) {
  final signer = ref.watch(userSignerProvider);
  return signer is AmberSigner && signer.isSignedIn;
});

// User Progress Management
final userProgressProvider = StateNotifierProvider<UserProgressNotifier, UserProgress?>((ref) {
  return UserProgressNotifier(ref);
});

class UserProgressNotifier extends StateNotifier<UserProgress?> {
  UserProgressNotifier(this.ref) : super(null);
  
  final Ref ref;

  void initializeProgress(String npub, String authority) {
    final totalItems = JQRData.allItems.length;
    state = UserProgress(
      npub: npub,
      selectedAuthority: authority,
      itemAttestations: {},
      lastUpdated: DateTime.now(),
      currentLevel: QualificationLevel.basic,
      totalItems: totalItems,
      totalItemsCompleted: 0,
    );
  }

  void updateItemAttestation(String itemId, JQRAttestation attestation) {
    if (state == null) return;
    
    final updatedAttestations = Map<String, JQRAttestation>.from(state!.itemAttestations);
    updatedAttestations[itemId] = attestation;
    
    final completedCount = updatedAttestations.values
        .where((a) => a.status == AttestationStatus.completed)
        .length;
    
    state = state!.copyWith(
      itemAttestations: updatedAttestations,
      totalItemsCompleted: completedCount,
      lastUpdated: DateTime.now(),
    );
  }

  void setSelectedAuthority(String authority) {
    if (state == null) return;
    state = state!.copyWith(selectedAuthority: authority);
  }

  double getProgressPercentage() {
    if (state == null || state!.totalItems == 0) return 0.0;
    return state!.totalItemsCompleted / state!.totalItems;
  }

  QualificationLevel calculateCurrentLevel() {
    if (state == null) return QualificationLevel.basic;
    
    final completed = state!.itemAttestations.values
        .where((a) => a.status == AttestationStatus.completed)
        .map((a) => JQRData.getItem(a.itemId))
        .where((item) => item != null)
        .cast<JQRItem>()
        .toList();
    
    final journeymanItems = completed.where((item) => item.level == QualificationLevel.journeyman).length;
    final advancedItems = completed.where((item) => item.level == QualificationLevel.advanced).length;
    final masterItems = completed.where((item) => item.level == QualificationLevel.master).length;
    
    // Simple qualification logic - can be enhanced
    if (masterItems > 0) return QualificationLevel.master;
    if (advancedItems > 0) return QualificationLevel.advanced;
    if (journeymanItems > 0) return QualificationLevel.journeyman;
    return QualificationLevel.basic;
  }
}

// JQR Authorities
final jqrAuthoritiesProvider = Provider<List<JQRAuthority>>((ref) {
  return [
    const JQRAuthority(
      nip05Domain: 'bitcoinveterans.org',
      name: 'Bitcoin Veterans',
      description: 'Official Bitcoin Veterans JQR Authority',
      authorizedSMEs: [], // Will be populated from NIP-05 verification
    ),
    // Add more authorities as needed
  ];
});

final selectedAuthorityProvider = StateProvider<JQRAuthority?>((ref) => null);

// Attestation Management
final attestationProvider = StateNotifierProvider<AttestationNotifier, List<JQRAttestation>>((ref) {
  return AttestationNotifier(ref);
});

class AttestationNotifier extends StateNotifier<List<JQRAttestation>> {
  AttestationNotifier(this.ref) : super([]);
  
  final Ref ref;

  void addAttestation(JQRAttestation attestation) {
    state = [...state, attestation];
    
    // Update user progress
    ref.read(userProgressProvider.notifier).updateItemAttestation(
      attestation.itemId,
      attestation,
    );
  }

  void updateAttestationStatus(String itemId, AttestationStatus status) {
    state = state.map((attestation) {
      if (attestation.itemId == itemId) {
        return attestation.copyWith(status: status);
      }
      return attestation;
    }).toList();
  }

  List<JQRAttestation> getPendingAttestations() {
    return state.where((a) => a.status == AttestationStatus.pendingSignature).toList();
  }

  List<JQRAttestation> getOfflineAttestations() {
    return state.where((a) => a.isOffline == true).toList();
  }
}

// Progress Statistics
final progressStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final progress = ref.watch(userProgressProvider);
  if (progress == null) {
    return {
      'totalItems': 0,
      'completedItems': 0,
      'progressPercentage': 0.0,
      'currentLevel': QualificationLevel.basic,
      'sectionProgress': <String, int>{},
    };
  }

  final sectionProgress = <String, int>{};
  for (final section in JQRData.allSections) {
    final completedInSection = progress.itemAttestations.values
        .where((a) => a.status == AttestationStatus.completed)
        .where((a) => JQRData.getItem(a.itemId)?.section == section.id)
        .length;
    sectionProgress[section.id] = completedInSection;
  }

  return {
    'totalItems': progress.totalItems,
    'completedItems': progress.totalItemsCompleted,
    'progressPercentage': progress.totalItems > 0 ? progress.totalItemsCompleted / progress.totalItems : 0.0,
    'currentLevel': ref.read(userProgressProvider.notifier).calculateCurrentLevel(),
    'sectionProgress': sectionProgress,
  };
});

