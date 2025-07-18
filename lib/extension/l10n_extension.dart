import 'package:bite/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// This extension simplifies access to localized strings by adding a `l10n`
// getter to the `BuildContext`. Instead of calling
// `AppLocalizations.of(context).[KEY]` every time, you can now use
// `context.l10n?.[KEY]`, making the code more concise and readable.

extension LocalizationExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
