import 'package:flutter/material.dart';
import 'package:task_master/app/ui/app.dart';

Future<void> bootstrap(Future<void> Function(Widget) builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  builder(const App());
}
