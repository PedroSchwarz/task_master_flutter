import 'package:flutter/material.dart';
import 'package:intl/find_locale.dart';
import 'package:task_master/app/dependencies/locators.dart';
import 'package:task_master/app/logging/logging_repository.dart';
import 'package:task_master/app/ui/app.dart';

Future<void> bootstrap(Future<void> Function(Widget) builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await findSystemLocale();

  await Locators().setup();

  final loggingRepository = getIt<LoggingRepository>();

  await loggingRepository.init();

  builder(const App());
}
