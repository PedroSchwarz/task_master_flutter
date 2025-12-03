import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingRepository {
  const LoggingRepository({required this.firebaseCrashlytics});

  static final _log = Logger('LoggingRepository');

  @visibleForTesting
  final FirebaseCrashlytics firebaseCrashlytics;

  Future<void> init() async {
    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((record) {
      if (record.level == Level.SEVERE) {
        if (kDebugMode) {
          print(
            '${record.level.name}: ${record.message}: ${record.time}: ${record.error}',
          );
        }
        firebaseCrashlytics.recordError(
          record.error,
          record.stackTrace,
          reason: 'Severe error',
        );
      }
      if (kDebugMode) {
        print('${record.level.name}: ${record.message}: ${record.time}');
      }
    });

    FlutterError.onError = firebaseCrashlytics.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      firebaseCrashlytics.recordError(error, stack, fatal: true);
      return true;
    };

    Isolate.current.addErrorListener(
      RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await firebaseCrashlytics.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
          fatal: true,
        );
      }).sendPort,
    );
  }

  Future<void> setIdentifier(String identifier) async {
    try {
      await firebaseCrashlytics.setUserIdentifier(identifier);
    } catch (e) {
      _log.severe('Error setting identifier: $e', e);
    }
  }

  Future<void> clearIdentifier() async {
    try {
      await firebaseCrashlytics.setUserIdentifier('');
    } catch (e) {
      _log.severe('Error clearing identifier: $e', e);
    }
  }
}
