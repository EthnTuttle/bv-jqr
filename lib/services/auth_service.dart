
import 'package:amber_signer/amber_signer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';

class AuthService {
  /// Sign in with Amber signer  
  static Future<AmberSigner?> signInWithAmber(WidgetRef ref) async {
    try {
      final amberSigner = AmberSigner(ref as Ref);
      
      // Check if Amber is available
      if (!await amberSigner.isAvailable) {
        throw Exception('Amber signer app is not installed. Please install the Amber signer app from Google Play Store.');
      }
      
      // Try auto sign-in first (if previously signed in)
      final autoSignInSuccess = await amberSigner.attemptAutoSignIn();
      if (autoSignInSuccess) {
        return amberSigner;
      }
      
      // Manual sign-in required
      await amberSigner.signIn();
      return amberSigner;
    } catch (e) {
      throw Exception('Failed to authenticate with Amber: $e');
    }
  }

  /// Generate a test keypair for development
  static Map<String, dynamic> generateTestKeypair() {
    // Generate a realistic-looking npub for testing
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final testNpub = 'npub1${timestamp.toRadixString(36).padLeft(59, '0')}';
    
    return {
      'publicKey': {
        'npub': testNpub,
      },
      'isTest': true,
      'timestamp': timestamp,
    };
  }

  /// Validate that a signer is properly configured
  static bool isValidSigner(dynamic signer) {
    if (signer is AmberSigner) {
      return signer.isSignedIn && signer.pubkey.isNotEmpty;
    }
    
    if (signer is Map) {
      final npub = signer['publicKey']?['npub'] as String?;
      return npub != null && npub.startsWith('npub1') && npub.length >= 10;
    }
    
    return false;
  }

  /// Extract npub from various signer formats
  static String? extractNpub(dynamic signer) {
    if (signer is AmberSigner && signer.isSignedIn) {
      return signer.pubkey.encodeShareable(type: 'npub');
    }
    
    if (signer is Map) {
      return signer['publicKey']?['npub'] as String?;
    }
    
    return null;
  }

  /// Check if Amber is available on the device
  static Future<bool> isAmberAvailable(WidgetRef ref) async {
    try {
      final amberSigner = AmberSigner(ref as Ref);
      return await amberSigner.isAvailable;
    } catch (e) {
      return false;
    }
  }
}