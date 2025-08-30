import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Secondary button component with outlined neon styling
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width,
    this.height = 48,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;
    final Color effectiveBorderColor = borderColor ?? AppColors.primary;
    final Color effectiveTextColor = textColor ?? AppColors.primary;
    
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveTextColor,
          disabledForegroundColor: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
          side: BorderSide(
            color: isEnabled 
                ? effectiveBorderColor 
                : AppColors.onSurfaceVariant.withValues(alpha: 0.3),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.small,
          ),
        ),
        child: _buildContent(effectiveTextColor),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: textColor,
          ),
          const SizedBox(width: AppSpacing.small),
          Text(
            text,
            style: AppTextStyles.buttonLarge.copyWith(
              color: textColor,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppTextStyles.buttonLarge.copyWith(
        color: textColor,
      ),
    );
  }
}

/// Large secondary button variant
class LargeSecondaryButton extends StatelessWidget {
  const LargeSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      borderColor: borderColor,
      textColor: textColor,
      width: double.infinity,
      height: 56,
    );
  }
}

/// Text button variant for subtle actions
class TextSecondaryButton extends StatelessWidget {
  const TextSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = textColor ?? AppColors.primary;
    
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveTextColor,
        disabledForegroundColor: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.medium,
          vertical: AppSpacing.small,
        ),
      ),
      child: icon != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: effectiveTextColor,
                ),
                const SizedBox(width: AppSpacing.small),
                Text(
                  text,
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: effectiveTextColor,
                  ),
                ),
              ],
            )
          : Text(
              text,
              style: AppTextStyles.buttonLarge.copyWith(
                color: effectiveTextColor,
              ),
            ),
    );
  }
}