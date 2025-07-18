import 'package:bite/l10n/app_localizations.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/repository/manager/repo_manager/repository_manager.dart';
import 'package:bite/utils/logger.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    BiteLogger().error('Error loading .env file: $e');
  }

  _runApp();
}

void _runApp() async {
  await RepoManager().setManager();
  // Set the status bar text color to dark (suitable for a light app)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      // Italian
      // English
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: 'Urbanist',
        colorScheme: biteColorsTheme,
        useMaterial3: true,
      ),
    );
  }
}
