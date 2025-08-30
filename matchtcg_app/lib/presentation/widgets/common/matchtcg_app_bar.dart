import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom AppBar component for MatchTCG with neon brand styling
class MatchTCGAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MatchTCGAppBar({
    super.key,
    this.title,
    this.actions,
    this.showBackButton = true,
    this.backgroundColor,
    this.centerTitle = false,
    this.leading,
  });

  final String? title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final bool centerTitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.headlineMedium,
            )
          : null,
      backgroundColor: backgroundColor ?? AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: AppSpacing.elevation2,
      centerTitle: centerTitle,
      leading: leading ?? (showBackButton ? _buildBackButton(context) : null),
      actions: actions != null ? _buildActions() : null,
      automaticallyImplyLeading: showBackButton,
    );
  }

  Widget? _buildBackButton(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.onSurface,
        ),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: 'Back',
      );
    }
    return null;
  }

  List<Widget> _buildActions() {
    return actions!.map((action) {
      if (action is IconButton) {
        return IconButton(
          icon: action.icon,
          onPressed: action.onPressed,
          tooltip: action.tooltip,
          color: AppColors.onSurface,
        );
      }
      return action;
    }).toList();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Brand logo widget for app bar
class MatchTCGLogo extends StatelessWidget {
  const MatchTCGLogo({
    super.key,
    this.height = 32,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pin + Card motif icon
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              border: Border.all(
                color: AppColors.primary,
                width: 1.5,
              ),
              gradient: AppColors.primaryGradient,
            ),
            child: const Icon(
              Icons.place,
              color: AppColors.onPrimary,
              size: 16,
            ),
          ),
          const SizedBox(width: AppSpacing.small),
          Flexible(
            child: Text(
              'MatchTCG',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}