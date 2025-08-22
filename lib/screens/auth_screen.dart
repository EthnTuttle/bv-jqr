import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/jqr_providers.dart';
import '../services/auth_service.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final errorMessage = useState<String?>(null);
    final amberAvailable = useState<bool?>(null);

    // Check Amber availability when the screen loads
    useEffect(() {
      AuthService.isAmberAvailable(ref).then((available) {
        amberAvailable.value = available;
      });
      return null;
    }, []);

    Future<void> signInWithAmber() async {
      try {
        isLoading.value = true;
        errorMessage.value = null;

        // Use the auth service to get AmberSigner
        final amberSigner = await AuthService.signInWithAmber(ref);
        
        if (amberSigner != null && amberSigner.isSignedIn) {
          ref.read(userSignerProvider.notifier).state = amberSigner;
          
          // Initialize user progress with default authority
          final npub = AuthService.extractNpub(amberSigner);
          if (npub != null) {
            ref.read(userProgressProvider.notifier).initializeProgress(
              npub,
              'bitcoinveterans.org',
            );
            
            if (context.mounted) {
              context.go('/home');
            }
          } else {
            errorMessage.value = 'Failed to extract npub from Amber signer';
          }
        } else {
          errorMessage.value = 'Failed to sign in with Amber signer';
        }
      } catch (e) {
        errorMessage.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    }

    Future<void> signInWithKeyPair() async {
      try {
        isLoading.value = true;
        errorMessage.value = null;
        
        // Generate a test keypair for development
        final testKeypair = AuthService.generateTestKeypair();
        
        ref.read(userSignerProvider.notifier).state = testKeypair;
        
        final npub = AuthService.extractNpub(testKeypair);
        if (npub != null) {
          ref.read(userProgressProvider.notifier).initializeProgress(
            npub,
            'bitcoinveterans.org',
          );
        }
        
        if (context.mounted) {
          context.go('/home');
        }
      } catch (e) {
        errorMessage.value = 'Failed to generate test keypair: ${e.toString()}';
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40), // Add some top padding
              // Logo and Title
              Icon(
                Icons.military_tech,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              
              Text(
                'BV-JQR Tracker',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Bitcoin Veterans Job Qualification Requirements',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Mission Statement
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mission',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'To educate and qualify the warrior class in Bitcoin skills, promoting professional competency and peer-to-peer verification systems.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildPrincipleChip(context, 'Bitcoin Only'),
                        _buildPrincipleChip(context, 'Professional Standards'),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Error Message
              if (errorMessage.value != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    errorMessage.value!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              
              // Sign In Buttons
              ElevatedButton.icon(
                onPressed: (isLoading.value || amberAvailable.value == false) ? null : signInWithAmber,
                icon: isLoading.value 
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      amberAvailable.value == false ? Icons.warning : Icons.key,
                      color: amberAvailable.value == false ? Colors.orange : null,
                    ),
                label: Text(
                  isLoading.value 
                    ? 'Connecting...' 
                    : amberAvailable.value == false 
                      ? 'Amber Not Installed'
                      : amberAvailable.value == null
                        ? 'Checking Amber...'
                        : 'Sign in with Amber'
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: amberAvailable.value == false 
                    ? Colors.orange.withValues(alpha: 0.2)
                    : null,
                ),
              ),
              
              // Amber installation help
              if (amberAvailable.value == false) ...[
                const SizedBox(height: 8),
                Text(
                  'Install the Amber signer app from Zapstore.dev to use Nostr authentication',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              
              const SizedBox(height: 16),
              
              OutlinedButton.icon(
                onPressed: isLoading.value ? null : signInWithKeyPair,
                icon: const Icon(Icons.vpn_key),
                label: const Text('Generate Test Keypair'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Info Section
              Text(
                'Authenticate with your Nostr keypair to track your JQR progress and receive attestations from verified SMEs.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrincipleChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}