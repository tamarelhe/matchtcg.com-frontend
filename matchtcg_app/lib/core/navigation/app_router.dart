import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/events/events_screen.dart';
import '../../presentation/screens/groups/groups_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/widgets/navigation/main_shell.dart';
import '../providers/auth_providers.dart';

/// Application routing configuration using GoRouter
class AppRouter {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String events = '/events';
  static const String groups = '/groups';
  static const String profile = '/profile';
}

/// Provider that only watches auth properties relevant to routing
final _routingAuthStateProvider =
    Provider<({bool isLoading, bool isAuthenticated})>((ref) {
      final authState = ref.watch(authNotifierProvider);
      return (
        isLoading: authState.isLoading,
        isAuthenticated: authState.isAuthenticated,
      );
    });

/// GoRouter provider that reacts to auth state changes
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(_routingAuthStateProvider);

  return GoRouter(
    initialLocation: AppRouter.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthRoute = state.matchedLocation == AppRouter.auth;

      // If still loading, don't redirect
      if (authState.isLoading) {
        return null;
      }

      // If not authenticated and not on auth route, redirect to auth
      if (!authState.isAuthenticated && !isAuthRoute) {
        return AppRouter.auth;
      }

      // If authenticated and on auth route, redirect to home
      if (authState.isAuthenticated && isAuthRoute) {
        return AppRouter.home;
      }

      return null;
    },
    routes: [
      // Authentication route
      GoRoute(
        path: AppRouter.auth,
        name: 'auth',
        pageBuilder:
            (context, state) => const NoTransitionPage(child: AuthScreen()),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRouter.home,
            name: 'home',
            pageBuilder:
                (context, state) => const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: AppRouter.events,
            name: 'events',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: EventsScreen()),
          ),
          GoRoute(
            path: AppRouter.groups,
            name: 'groups',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: GroupsScreen()),
          ),
          GoRoute(
            path: AppRouter.profile,
            name: 'profile',
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  state.error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go(AppRouter.home),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
  );
});

/// Navigation helper methods
extension AppRouterExtension on BuildContext {
  void goToHome() => go(AppRouter.home);
  void goToEvents() => go(AppRouter.events);
  void goToGroups() => go(AppRouter.groups);
  void goToProfile() => go(AppRouter.profile);
}
