import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'MatchTCG'**
  String get appTitle;

  /// Home tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// Events tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTab;

  /// Groups tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groupsTab;

  /// Profile tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Create account button text
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Text asking if user already has an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Text asking if user doesn't have an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Google OAuth sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// Apple OAuth sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signInWithApple;

  /// Title for nearby events section
  ///
  /// In en, this message translates to:
  /// **'Nearby Events'**
  String get nearbyEvents;

  /// Message when no events are found
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventsFound;

  /// Create event button text
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEvent;

  /// Event title field label
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get eventTitle;

  /// Event description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get eventDescription;

  /// Game selection field label
  ///
  /// In en, this message translates to:
  /// **'Select Game'**
  String get selectGame;

  /// Event start date field label
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// Event end date field label
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// Venue field label
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// Event capacity field label
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity;

  /// Event entry fee field label
  ///
  /// In en, this message translates to:
  /// **'Entry Fee'**
  String get entryFee;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button text
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Share button text
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// RSVP status: going
  ///
  /// In en, this message translates to:
  /// **'Going'**
  String get going;

  /// RSVP status: interested
  ///
  /// In en, this message translates to:
  /// **'Interested'**
  String get interested;

  /// RSVP status: declined
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get declined;

  /// Attendees list title
  ///
  /// In en, this message translates to:
  /// **'Attendees'**
  String get attendees;

  /// Settings screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Portuguese language option
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Filter button text
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// All filter option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// Display name field label
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get displayName;

  /// Optional display name field label
  ///
  /// In en, this message translates to:
  /// **'Display Name (Optional)'**
  String get displayNameOptional;

  /// Email validation error message
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// Invalid email format error message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// Password validation error message
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Password too short error message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordTooShort;

  /// Confirm password validation error message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// Password mismatch error message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Sign out confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// Sign out confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// Generic authentication failure message
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authenticationFailed;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network connection failed'**
  String get networkError;

  /// Edit profile screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Personal information section title
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Preferences section title
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Timezone field label
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get timezone;

  /// City field label
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Country field label
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Privacy and data section title
  ///
  /// In en, this message translates to:
  /// **'Privacy & Data'**
  String get privacyAndData;

  /// Export data button text
  ///
  /// In en, this message translates to:
  /// **'Export My Data'**
  String get exportData;

  /// Delete account button text
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Delete account confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// Export data description
  ///
  /// In en, this message translates to:
  /// **'Download all your data in a machine-readable format'**
  String get exportDataDescription;

  /// Delete account description
  ///
  /// In en, this message translates to:
  /// **'Permanently delete your account and all associated data'**
  String get deleteAccountDescription;

  /// Profile update success message
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// Account deletion success message
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get accountDeleted;

  /// Data export success message
  ///
  /// In en, this message translates to:
  /// **'Data exported successfully'**
  String get dataExported;

  /// Update profile button text
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// Language and region settings title
  ///
  /// In en, this message translates to:
  /// **'Language & Region'**
  String get languageAndRegion;

  /// Timezone selection title
  ///
  /// In en, this message translates to:
  /// **'Select Timezone'**
  String get selectTimezone;

  /// Current timezone label
  ///
  /// In en, this message translates to:
  /// **'Current Timezone'**
  String get currentTimezone;

  /// Updating indicator text
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// Deleting indicator text
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get deleting;

  /// Exporting indicator text
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exporting;

  /// Country name: Portugal
  ///
  /// In en, this message translates to:
  /// **'Portugal'**
  String get countryPT;

  /// Country name: Spain
  ///
  /// In en, this message translates to:
  /// **'Spain'**
  String get countryES;

  /// Country name: France
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFR;

  /// Country name: Germany
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryDE;

  /// Country name: Italy
  ///
  /// In en, this message translates to:
  /// **'Italy'**
  String get countryIT;

  /// Country name: United Kingdom
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get countryGB;

  /// Country name: United States
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get countryUS;

  /// Country name: Brazil
  ///
  /// In en, this message translates to:
  /// **'Brazil'**
  String get countryBR;

  /// Country name: Netherlands
  ///
  /// In en, this message translates to:
  /// **'Netherlands'**
  String get countryNL;

  /// Country name: Belgium
  ///
  /// In en, this message translates to:
  /// **'Belgium'**
  String get countryBE;

  /// Country name: Switzerland
  ///
  /// In en, this message translates to:
  /// **'Switzerland'**
  String get countryCH;

  /// Country name: Austria
  ///
  /// In en, this message translates to:
  /// **'Austria'**
  String get countryAT;

  /// Country name: Ireland
  ///
  /// In en, this message translates to:
  /// **'Ireland'**
  String get countryIE;

  /// Country name: Luxembourg
  ///
  /// In en, this message translates to:
  /// **'Luxembourg'**
  String get countryLU;

  /// Country name: Denmark
  ///
  /// In en, this message translates to:
  /// **'Denmark'**
  String get countryDK;

  /// Country name: Sweden
  ///
  /// In en, this message translates to:
  /// **'Sweden'**
  String get countrySE;

  /// Country name: Norway
  ///
  /// In en, this message translates to:
  /// **'Norway'**
  String get countryNO;

  /// Country name: Finland
  ///
  /// In en, this message translates to:
  /// **'Finland'**
  String get countryFI;

  /// Country name: Poland
  ///
  /// In en, this message translates to:
  /// **'Poland'**
  String get countryPL;

  /// Country name: Czech Republic
  ///
  /// In en, this message translates to:
  /// **'Czech Republic'**
  String get countryCZ;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
