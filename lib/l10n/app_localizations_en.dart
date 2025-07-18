// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get creditsCompanyLabel => 'OverApp S.r.l';

  @override
  String get creditsTextLabel =>
      'This App is part of the project BITE which has received funding from Cascade funding calls of NODES Program, supported by the MUR - M4C2 1.5 of PNRR funded by the European Union - NextGenerationEU (Grant agreement no. ECS00000036).';

  @override
  String get nextLabel => 'Next';

  @override
  String get reportScreen => 'Report';

  @override
  String get bluetoothPermissionInfoLabel =>
      'The BiTe app uses the Bluetooth connection to find points of interest near you.';

  @override
  String get reports => 'Report';

  @override
  String get reportAProblem => 'Report a problem';

  @override
  String get email => 'Insert email';

  @override
  String get reportProblemHintText =>
      'Tell us the problem (max. 150 characters)';

  @override
  String get sendText => 'Send';

  @override
  String get takeAPhoto => 'Take a photo';

  @override
  String get orLabel => 'or';

  @override
  String get browse => 'Browse';

  @override
  String get searchPOI => 'Search for a point of interest';

  @override
  String get showMoreResults => 'Show more';

  @override
  String get attentionLabel => 'Attention';

  @override
  String get missingPhotoLibraryPermission =>
      'Permits for access to the photo library were not granted';

  @override
  String get operationCompleted => 'Completed';

  @override
  String get sendReport => 'We have forwarded your report';

  @override
  String get availableServices => 'Services available';

  @override
  String get openingHours => 'Opening hours';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get homeTabLabel => 'Map';

  @override
  String get routesTabLabel => 'Routes';

  @override
  String get routesSearchBarHintText => 'Search route';

  @override
  String get noRoutesFound => 'No routes found';

  @override
  String get departureLabel => 'Departure ';

  @override
  String get arriveLabel => 'Arrive ';

  @override
  String get pointsOfInterestLabel => 'Points of interest';

  @override
  String get startRoute => 'Start route';

  @override
  String get goToRoute => 'Go to route';

  @override
  String get availableRoutes => 'available routes';

  @override
  String get pemissionDeniedLabel =>
      'Without access to your location we cannot show you Points Of Interest!';

  @override
  String get goToSettings => 'Go to settings';

  @override
  String get errorTitle => 'Error';

  @override
  String get genericError => 'An error occurred!';

  @override
  String get tryAgain => 'Try again';

  @override
  String get invalidFormat => 'Invalid format';

  @override
  String get enableLabel => 'Enable';

  @override
  String get closeLabel => 'Close';

  @override
  String get okLabel => 'Ok';

  @override
  String get creditsScreenTitle => 'Credits';

  @override
  String get madeWithLove => 'Made with love by';

  @override
  String get imageFormatError => 'The format of the inserted image is invalid';

  @override
  String get previewLabel => 'Preview';

  @override
  String get takeAnotherPhoto => 'Take another photo';

  @override
  String get continueWithReport => 'Continue with the report';

  @override
  String get removeLabel => 'Remove';

  @override
  String get archeology => 'Archeology';

  @override
  String get monuments => 'Monuments';

  @override
  String get tradition => 'Tradition';

  @override
  String get trekking => 'Trekking';

  @override
  String get undefined => 'Undefinied';

  @override
  String get noItemsFound => 'No items found';

  @override
  String get poiCount => 'found POI';

  @override
  String get activateRoute => 'Activate route';

  @override
  String get vistPoiQuestion => 'Do you want to visit this point of interest?';

  @override
  String get goToRouteLabel => 'Go';

  @override
  String get dontVisit => 'Don\'t visit';

  @override
  String get alreadyActiveRoute => 'There is already an active route';

  @override
  String get alreadyActiveRouteMessage =>
      'It is possible to have only one active path, starting a new one will overwrite the current one';

  @override
  String get startNewRoute => 'Start new route';

  @override
  String get cancelLabel => 'Cancel';

  @override
  String get completeRoute => 'Congratulations! You have completed the course';

  @override
  String visitedLabel(Object count) {
    return 'You have visited $count POIs';
  }
}
