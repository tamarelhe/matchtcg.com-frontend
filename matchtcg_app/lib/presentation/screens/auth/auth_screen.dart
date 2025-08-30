import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/localization_extension.dart';
import '../../../core/providers/auth_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../widgets/common/matchtcg_app_bar.dart';
import '../../widgets/common/matchtcg_text_field.dart';
import '../../widgets/common/primary_button.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'widgets/oauth_buttons.dart';

// Provider para manter o estado do modo de autenticação
final _authModeProvider = StateProvider<bool>(
  (ref) => true,
); // true = login, false = register

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _cityController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedCountry;

  // Lista de países com códigos ISO
  final Map<String, String> _countries = {
    'PT': 'Portugal',
    'ES': 'Espanha',
    'FR': 'França',
    'DE': 'Alemanha',
    'IT': 'Itália',
    'GB': 'Reino Unido',
    'US': 'Estados Unidos',
    'BR': 'Brasil',
    'NL': 'Países Baixos',
    'BE': 'Bélgica',
    'CH': 'Suíça',
    'AT': 'Áustria',
    'IE': 'Irlanda',
    'LU': 'Luxemburgo',
    'DK': 'Dinamarca',
    'SE': 'Suécia',
    'NO': 'Noruega',
    'FI': 'Finlândia',
    'PL': 'Polónia',
    'CZ': 'República Checa',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    final currentMode = ref.read(_authModeProvider);

    // Update the provider state
    ref.read(_authModeProvider.notifier).state = !currentMode;

    setState(() {
      _formKey.currentState?.reset();
      // Clear additional fields when switching modes
      _selectedCountry = null;
      _cityController.clear();
    });
    ref.read(authNotifierProvider.notifier).clearError();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final isLoginMode = ref.read(_authModeProvider);
    if (!isLoginMode) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }

      if (value != _passwordController.text) {
        return 'Passwords do not match';
      }
    }

    return null;
  }

  String? _validateCountry(String? value) {
    final isLoginMode = ref.read(_authModeProvider);
    if (!isLoginMode && (value == null || value.isEmpty)) {
      return 'Please select a country';
    }
    return null;
  }

  String? _validateCity(String? value) {
    final isLoginMode = ref.read(_authModeProvider);
    if (!isLoginMode && (value == null || value.isEmpty)) {
      return 'Please enter your city';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authNotifierProvider.notifier);
    final isLoginMode = ref.read(_authModeProvider);

    if (isLoginMode) {
      await authNotifier.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    } else {
      // Get current locale and timezone for registration
      final locale = Localizations.localeOf(context);
      //final timezone = DateTime.now().timeZoneName;
      final String timeZoneName =
          await FlutterNativeTimezone.getLocalTimezone();

      await authNotifier.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        timezone: timeZoneName,
        locale: locale.languageCode,
        displayName:
            _displayNameController.text.trim().isEmpty
                ? null
                : _displayNameController.text.trim(),
        country: _selectedCountry,
        city:
            _cityController.text.trim().isEmpty
                ? null
                : _cityController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoginMode = ref.watch(_authModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: MatchTCGAppBar(
        title: isLoginMode ? context.l10n.login : context.l10n.register,
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.large),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App logo/title
                Icon(
                  Icons.casino_outlined,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.medium),
                Text(
                  context.l10n.appTitle,
                  style: theme.textTheme.displayMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxLarge),

                // Display name field (register only)
                if (!isLoginMode) ...[
                  MatchTCGTextField(
                    controller: _displayNameController,
                    label: 'Display Name (Optional)',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.medium),

                  // Country dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items:
                        _countries.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    validator: _validateCountry,
                  ),
                  const SizedBox(height: AppSpacing.medium),

                  // City field
                  MatchTCGTextField(
                    controller: _cityController,
                    label: 'City',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: _validateCity,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                ],

                // Email field
                MatchTCGTextField(
                  controller: _emailController,
                  label: context.l10n.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.medium),

                // Password field
                MatchTCGTextField(
                  controller: _passwordController,
                  label: context.l10n.password,
                  obscureText: _obscurePassword,
                  textInputAction:
                      isLoginMode ? TextInputAction.done : TextInputAction.next,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: AppSpacing.medium),

                // Confirm password field (register only)
                if (!isLoginMode) ...[
                  MatchTCGTextField(
                    controller: _confirmPasswordController,
                    label: context.l10n.confirmPassword,
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    validator: _validateConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.medium),
                ],

                // Error message
                if (authState.error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.medium),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.error.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                        const SizedBox(width: AppSpacing.small),
                        Expanded(
                          child: Text(
                            authState.error!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.medium),
                ],

                // Submit button
                PrimaryButton(
                  text:
                      isLoginMode
                          ? context.l10n.login
                          : context.l10n.createAccount,
                  onPressed: authState.isLoading ? null : _submitForm,
                  isLoading: authState.isLoading,
                ),
                const SizedBox(height: AppSpacing.large),

                // Divider with "OR"
                Row(
                  children: [
                    Expanded(child: Divider(color: theme.colorScheme.outline)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.medium,
                      ),
                      child: Text(
                        'OR',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: theme.colorScheme.outline)),
                  ],
                ),
                const SizedBox(height: AppSpacing.large),

                // OAuth buttons
                OAuthButtons(isLoading: authState.isLoading),
                const SizedBox(height: AppSpacing.xxLarge),

                // Toggle between login/register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLoginMode
                          ? context.l10n.dontHaveAccount
                          : context.l10n.alreadyHaveAccount,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: AppSpacing.small),
                    TextButton(
                      onPressed:
                          authState.isLoading
                              ? null
                              : () {
                                _toggleMode();
                              },
                      child: Text(
                        isLoginMode
                            ? context.l10n.register
                            : context.l10n.login,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
