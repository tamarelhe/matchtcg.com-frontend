import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/extensions/localization_extension.dart';

/// Main shell widget with bottom navigation for the app
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const MatchTCGBottomNavigation(),
    );
  }
}

/// Custom bottom navigation bar with MatchTCG styling
class MatchTCGBottomNavigation extends StatelessWidget {
  const MatchTCGBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentLocation = GoRouterState.of(context).uri.path;
    final int currentIndex = _getCurrentIndex(currentLocation);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outline, width: 0.5)),
      ),
      child: SafeArea(
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.small,
            vertical: AppSpacing.micro,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.map_outlined,
                activeIcon: Icons.map,
                label: context.l10n.homeTab,
                isActive: currentIndex == 0,
                onTap: () => context.goToHome(),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.event_outlined,
                activeIcon: Icons.event,
                label: context.l10n.eventsTab,
                isActive: currentIndex == 1,
                onTap: () => context.goToEvents(),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.group_outlined,
                activeIcon: Icons.group,
                label: context.l10n.groupsTab,
                isActive: currentIndex == 2,
                onTap: () => context.goToGroups(),
              ),
              _buildNavItem(
                context: context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: context.l10n.profileTab,
                isActive: currentIndex == 3,
                onTap: () => context.goToProfile(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration:
                    isActive
                        ? BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusSmall,
                          ),
                        )
                        : null,
                child: Icon(
                  isActive ? activeIcon : icon,
                  size: 20,
                  color:
                      isActive ? AppColors.primary : AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color:
                        isActive
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(String location) {
    switch (location) {
      case AppRouter.home:
        return 0;
      case AppRouter.events:
        return 1;
      case AppRouter.groups:
        return 2;
      case AppRouter.profile:
        return 3;
      default:
        return 0;
    }
  }
}
