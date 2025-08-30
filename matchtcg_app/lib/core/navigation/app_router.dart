import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/events/events_screen.dart';
import '../../presentation/screens/groups/groups_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/widgets/navigation/main_shell.dart';

/// Application routing configuration using GoRouter
class AppRouter {
  static const String home = '/home';
  static const String events = '/events';
  static const String groups = '/groups';
  static const String profile = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    debugLogDiagnostics: true,
    routes: [
      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: home,
            name: 'home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: events,
            name: 'events',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EventsScreen(),
            ),
          ),
          GoRoute(
            path: groups,
            name: 'groups',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: GroupsScreen(),
            ),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
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
              onPressed: () => context.go(home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Navigation helper methods
extension AppRouterExtension on BuildContext {
  void goToHome() => go(AppRouter.home);
  void goToEvents() => go(AppRouter.events);
  void goToGroups() => go(AppRouter.groups);
  void goToProfile() => go(AppRouter.profile);
}