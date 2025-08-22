import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/study_screen.dart';
import 'screens/community_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/section_detail_screen.dart';
import 'screens/navigation_shell.dart';
import 'providers/jqr_providers.dart';
import 'services/auth_service.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      final userSigner = ref.read(userSignerProvider);
      final isAuthenticated = AuthService.isValidSigner(userSigner);
      
      // If not authenticated and trying to access protected routes, redirect to auth
      if (!isAuthenticated && !state.matchedLocation.startsWith('/auth')) {
        return '/auth';
      }
      
      // If authenticated and on auth screen, redirect to home
      if (isAuthenticated && state.matchedLocation.startsWith('/auth')) {
        return '/home';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      
      ShellRoute(
        builder: (context, state, child) => NavigationShell(
          location: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/study',
            builder: (context, state) => const StudyScreen(),
            routes: [
              GoRoute(
                path: '/section/:sectionId',
                builder: (context, state) {
                  final sectionId = state.pathParameters['sectionId']!;
                  return SectionDetailScreen(sectionId: sectionId);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/community',
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Additional routes for future features
      GoRoute(
        path: '/attestations',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Attestations')),
          body: const Center(
            child: Text('Attestation management\nComing soon!'),
          ),
        ),
      ),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Analytics')),
          body: const Center(
            child: Text('Progress analytics\nComing soon!'),
          ),
        ),
      ),
    ],
  );
});
