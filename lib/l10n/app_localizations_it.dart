// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get creditsCompanyLabel => 'OverApp S.r.l';

  @override
  String get creditsTextLabel =>
      'Questa App fa parte del progetto BITE finanziato nell’ambito dei Bandi a Cascata del Programma NODES, sostenuto dal MUR sui fondi PNRR MUR - M4C2 - Investimento 1.5 Avviso \"Ecosistemi dell\'Innovazione\", nell\'ambito del PNRR finanziato dall’Unione europea – NextGenerationEU (Grant agreement Cod. n.ECS00000036).';

  @override
  String get nextLabel => 'Avanti';

  @override
  String get reportScreen => 'Segnala';

  @override
  String get bluetoothPermissionInfoLabel =>
      'L’app BiTe utilizza la connessione bluetooth per individuare punti di interesse nelle tue vicinanze.';

  @override
  String get reports => 'Segnalazione';

  @override
  String get reportAProblem => 'Segnala un problema';

  @override
  String get email => 'Insert email';

  @override
  String get reportProblemHintText =>
      'Raccontaci il problema (max. 150 caratteri)';

  @override
  String get sendText => 'Invia';

  @override
  String get takeAPhoto => 'Scatta una foto';

  @override
  String get orLabel => 'oppure';

  @override
  String get browse => 'Sfoglia';

  @override
  String get searchPOI => 'Cerca un punto di interesse';

  @override
  String get showMoreResults => 'Mostra altri';

  @override
  String get attentionLabel => 'Attenzione';

  @override
  String get missingPhotoLibraryPermission =>
      'Non sono stati concessi i permessi per l\'accesso alla galleria';

  @override
  String get operationCompleted => 'Operazione completata';

  @override
  String get sendReport => 'Abbiamo inoltrato la tua segnalazione';

  @override
  String get availableServices => 'Servizi disponibili';

  @override
  String get openingHours => 'Orari di apertura';

  @override
  String get descriptionLabel => 'Descrizione';

  @override
  String get homeTabLabel => 'Mappa';

  @override
  String get routesTabLabel => 'Percorsi';

  @override
  String get routesSearchBarHintText => 'Cerca un percorso';

  @override
  String get noRoutesFound => 'Nessun percorso trovato';

  @override
  String get departureLabel => 'Partenza:';

  @override
  String get arriveLabel => 'Arrivo:';

  @override
  String get pointsOfInterestLabel => 'Punti di interesse';

  @override
  String get startRoute => 'Inizia percorso';

  @override
  String get goToRoute => 'Vedi percorso';

  @override
  String get availableRoutes => 'percorsi disponibili';

  @override
  String get pemissionDeniedLabel =>
      'Senza accesso alla tua posizione non possiamo farti vedere i punti di interesse!';

  @override
  String get goToSettings => 'Vai alle impostazioni';

  @override
  String get errorTitle => 'Errore';

  @override
  String get genericError => 'Si è verificato un errore inaspettato';

  @override
  String get tryAgain => 'Riprova';

  @override
  String get invalidFormat => 'Formato non valido';

  @override
  String get enableLabel => 'Abilita';

  @override
  String get closeLabel => 'Chiudi';

  @override
  String get okLabel => 'OK';

  @override
  String get creditsScreenTitle => 'Credits';

  @override
  String get madeWithLove => 'Made with love by';

  @override
  String get imageFormatError =>
      'Il formato dell\'immagine inseritab non è valido';

  @override
  String get previewLabel => 'Anteprima';

  @override
  String get takeAnotherPhoto => 'Scatta un\'altra foto';

  @override
  String get continueWithReport => 'Prosegui con la segnalazione';

  @override
  String get removeLabel => 'Rimuovi';

  @override
  String get archeology => 'Archeologia';

  @override
  String get monuments => 'Monumenti';

  @override
  String get tradition => 'Tradizioni';

  @override
  String get trekking => 'Trekking';

  @override
  String get undefined => 'Undefinied';

  @override
  String get noItemsFound =>
      'Non è stato trovato alcun risultato per la tua ricerca';

  @override
  String get poiCount => 'POI tovati';

  @override
  String get activateRoute => 'Attiva percorso';

  @override
  String get vistPoiQuestion => 'Vuoi visitare questo punto di interesse?';

  @override
  String get goToRouteLabel => 'Vai';

  @override
  String get dontVisit => 'Non visitare';

  @override
  String get alreadyActiveRoute => 'Hai già un percorso attivo';

  @override
  String get alreadyActiveRouteMessage =>
      'È possibile avere un solo percorso attivo, avviarne uno nuovo sovrascriverà quello corrente';

  @override
  String get startNewRoute => 'Avvia nuovo percorso';

  @override
  String get cancelLabel => 'Annulla';

  @override
  String get completeRoute => 'Complimenti! hai completato il percorso';

  @override
  String visitedLabel(Object count) {
    return 'Hai visitato $count POI';
  }
}
