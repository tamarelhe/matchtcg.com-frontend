import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Primary button component with MatchTCG neon styling
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null && !isLoading;
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: foregroundColor ?? AppColors.onPrimary,
          disabledBackgroundColor: AppColors.onSurfaceVariant.withValues(alpha: 0.3),
          disabledForegroundColor: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
          elevation: isEnabled ? AppSpacing.elevation1 : 0,
          shadowColor: AppColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            foregroundColor ?? AppColors.onPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: foregroundColor ?? AppColors.onPrimary,
          ),
          const SizedBox(width: AppSpacing.small),
          Text(
            text,
            style: AppTextStyles.buttonLarge.copyWith(
              color: foregroundColor ?? AppColors.onPrimary,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppTextStyles.buttonLarge.copyWith(
        color: foregroundColor ?? AppColors.onPrimary,
      ),
    );
  }
}

/// Large primary button variant for prominent actions
class LargePrimaryButton extends StatelessWidget {
  const LargePrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      width: double.infinity,
      height: 56,
    );
  }
}