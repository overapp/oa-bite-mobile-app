import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('it')
  ];

  /// company name
  ///
  /// In en, this message translates to:
  /// **'OverApp S.r.l'**
  String get creditsCompanyLabel;

  /// credits screen label
  ///
  /// In en, this message translates to:
  /// **'This App is part of the project BITE which has received funding from Cascade funding calls of NODES Program, supported by the MUR - M4C2 1.5 of PNRR funded by the European Union - NextGenerationEU (Grant agreement no. ECS00000036).'**
  String get creditsTextLabel;

  /// label for next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextLabel;

  /// button label in POI Detail Screen
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportScreen;

  /// label used in the permission screen
  ///
  /// In en, this message translates to:
  /// **'The BiTe app uses the Bluetooth connection to find points of interest near you.'**
  String get bluetoothPermissionInfoLabel;

  /// App Bar Text Report Screen
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reports;

  /// Report screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Report a problem'**
  String get reportAProblem;

  /// report screen hint text
  ///
  /// In en, this message translates to:
  /// **'Insert email'**
  String get email;

  /// text area hint text
  ///
  /// In en, this message translates to:
  /// **'Tell us the problem (max. 150 characters)'**
  String get reportProblemHintText;

  /// Send label
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get sendText;

  /// Report Screen label
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// Report Screen label
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orLabel;

  /// Report Screen button Label
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// hint text of the search bar on the home page
  ///
  /// In en, this message translates to:
  /// **'Search for a point of interest'**
  String get searchPOI;

  /// label for show other serach results
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMoreResults;

  /// label used inside alert
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attentionLabel;

  /// Alert message for photo library missing permission
  ///
  /// In en, this message translates to:
  /// **'Permits for access to the photo library were not granted'**
  String get missingPhotoLibraryPermission;

  /// alert title
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get operationCompleted;

  /// alert message
  ///
  /// In en, this message translates to:
  /// **'We have forwarded your report'**
  String get sendReport;

  /// poi detail title section
  ///
  /// In en, this message translates to:
  /// **'Services available'**
  String get availableServices;

  /// poi detail title section
  ///
  /// In en, this message translates to:
  /// **'Opening hours'**
  String get openingHours;

  /// description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// label home navigation bar
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get homeTabLabel;

  /// label routes navigation bar
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get routesTabLabel;

  /// hint text of search bar in routes screen
  ///
  /// In en, this message translates to:
  /// **'Search route'**
  String get routesSearchBarHintText;

  /// label for empty list of routes
  ///
  /// In en, this message translates to:
  /// **'No routes found'**
  String get noRoutesFound;

  /// Routes Detail screen label
  ///
  /// In en, this message translates to:
  /// **'Departure '**
  String get departureLabel;

  /// Routes Detail screen label
  ///
  /// In en, this message translates to:
  /// **'Arrive '**
  String get arriveLabel;

  /// Routes Detail screen label
  ///
  /// In en, this message translates to:
  /// **'Points of interest'**
  String get pointsOfInterestLabel;

  /// Button label used in route detail screen
  ///
  /// In en, this message translates to:
  /// **'Start route'**
  String get startRoute;

  /// Button label used in POI detail screen for show route with specific POI
  ///
  /// In en, this message translates to:
  /// **'Go to route'**
  String get goToRoute;

  /// label user in routes screen
  ///
  /// In en, this message translates to:
  /// **'available routes'**
  String get availableRoutes;

  /// label used in home screen when permissions are denied
  ///
  /// In en, this message translates to:
  /// **'Without access to your location we cannot show you Points Of Interest!'**
  String get pemissionDeniedLabel;

  /// label for going to device settings
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get goToSettings;

  /// title for error alert
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// generic error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred!'**
  String get genericError;

  /// button label for retrying an operation
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// error message for invalid format
  ///
  /// In en, this message translates to:
  /// **'Invalid format'**
  String get invalidFormat;

  /// label for enable button
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enableLabel;

  /// label for close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeLabel;

  /// label for ok button
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get okLabel;

  /// title for the credits screen
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get creditsScreenTitle;

  /// credits screen label
  ///
  /// In en, this message translates to:
  /// **'Made with love by'**
  String get madeWithLove;

  /// label for error alert
  ///
  /// In en, this message translates to:
  /// **'The format of the inserted image is invalid'**
  String get imageFormatError;

  ///  label used in camera screen
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewLabel;

  ///  label used in camera screen
  ///
  /// In en, this message translates to:
  /// **'Take another photo'**
  String get takeAnotherPhoto;

  ///  label used in camera screen
  ///
  /// In en, this message translates to:
  /// **'Continue with the report'**
  String get continueWithReport;

  ///  label used in report screen
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeLabel;

  /// routes category
  ///
  /// In en, this message translates to:
  /// **'Archeology'**
  String get archeology;

  /// routes category
  ///
  /// In en, this message translates to:
  /// **'Monuments'**
  String get monuments;

  /// routes category
  ///
  /// In en, this message translates to:
  /// **'Tradition'**
  String get tradition;

  /// routes category
  ///
  /// In en, this message translates to:
  /// **'Trekking'**
  String get trekking;

  /// routes category
  ///
  /// In en, this message translates to:
  /// **'Undefinied'**
  String get undefined;

  /// label for empty list
  ///
  /// In en, this message translates to:
  /// **'No items found'**
  String get noItemsFound;

  /// label for number of found POI
  ///
  /// In en, this message translates to:
  /// **'found POI'**
  String get poiCount;

  /// No description provided for @activateRoute.
  ///
  /// In en, this message translates to:
  /// **'Activate route'**
  String get activateRoute;

  /// No description provided for @vistPoiQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you want to visit this point of interest?'**
  String get vistPoiQuestion;

  /// No description provided for @goToRouteLabel.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get goToRouteLabel;

  /// No description provided for @dontVisit.
  ///
  /// In en, this message translates to:
  /// **'Don\'t visit'**
  String get dontVisit;

  /// No description provided for @alreadyActiveRoute.
  ///
  /// In en, this message translates to:
  /// **'There is already an active route'**
  String get alreadyActiveRoute;

  /// No description provided for @alreadyActiveRouteMessage.
  ///
  /// In en, this message translates to:
  /// **'It is possible to have only one active path, starting a new one will overwrite the current one'**
  String get alreadyActiveRouteMessage;

  /// No description provided for @startNewRoute.
  ///
  /// In en, this message translates to:
  /// **'Start new route'**
  String get startNewRoute;

  /// label for cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelLabel;

  /// No description provided for @completeRoute.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have completed the course'**
  String get completeRoute;

  /// No description provided for @visitedLabel.
  ///
  /// In en, this message translates to:
  /// **'You have visited {count} POIs'**
  String visitedLabel(Object count);
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
      <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
