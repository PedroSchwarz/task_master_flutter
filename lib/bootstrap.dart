import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_master/app/ui/app.dart';

Future<void> bootstrap(Future<void> Function(Widget) builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorageDirectory.web : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    if (record.level == Level.SEVERE) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.message}: ${record.time}: ${record.error}');
      }
    }
    if (kDebugMode) {
      print('${record.level.name}: ${record.message}: ${record.time}');
    }
  });

  builder(const App());
}
