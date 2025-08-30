import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Custom text field component with MatchTCG neon styling
class MatchTCGTextField extends StatefulWidget {
  const MatchTCGTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  State<MatchTCGTextField> createState() => _MatchTCGTextFieldState();
}

class _MatchTCGTextFieldState extends State<MatchTCGTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.labelMedium.copyWith(
              color: hasError 
                  ? AppColors.error 
                  : _isFocused 
                      ? AppColors.primary 
                      : AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          autofocus: widget.autofocus,
          style: AppTextStyles.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(
                      color: hasError 
                          ? AppColors.error 
                          : _isFocused 
                              ? AppColors.primary 
                              : AppColors.onSurfaceVariant,
                    ),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? IconTheme(
                    data: IconThemeData(
                      color: hasError 
                          ? AppColors.error 
                          : _isFocused 
                              ? AppColors.primary 
                              : AppColors.onSurfaceVariant,
                    ),
                    child: widget.suffixIcon!,
                  )
                : null,
            filled: true,
            fillColor: widget.enabled 
                ? AppColors.surface 
                : AppColors.surface.withValues(alpha: 0.5),
            border: _buildBorder(AppColors.outline),
            enabledBorder: _buildBorder(AppColors.outline),
            focusedBorder: _buildBorder(AppColors.primary, width: 2),
            errorBorder: _buildBorder(AppColors.error),
            focusedErrorBorder: _buildBorder(AppColors.error, width: 2),
            disabledBorder: _buildBorder(AppColors.outline.withValues(alpha: 0.5)),
            errorText: widget.errorText,
            errorStyle: AppTextStyles.labelMedium.copyWith(
              color: AppColors.error,
            ),
            helperText: widget.helperText,
            helperStyle: AppTextStyles.labelMedium,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.medium,
              vertical: AppSpacing.medium,
            ),
            counterStyle: AppTextStyles.labelMedium,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

/// Password text field with visibility toggle
class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MatchTCGTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        tooltip: _obscureText ? 'Show password' : 'Hide password',
      ),
    );
  }
}