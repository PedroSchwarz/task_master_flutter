import 'package:flutter/material.dart';
import 'package:task_master/app/dependencies/locators.dart';
import 'package:task_master/bootstrap.dart';

void main() async {
  await bootstrap((widget) async {
    await Locators().setup();
    runApp(widget);
  });
}
