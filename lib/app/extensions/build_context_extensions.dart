import 'package:flutter/material.dart';
import 'package:task_master/l10n/app_localizations.dart';

extension LocalizationContext on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
