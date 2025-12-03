import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  const AppLocalStorage({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static final _log = Logger('AppLocalStorage');

  Future<void> create() async {
    try {
      final isFirstRun = sharedPreferences.getBool('isFirstRun') ?? true;
      if (isFirstRun) {
        await secureStorage.deleteAll();
        await sharedPreferences.setBool('isFirstRun', false);
      }
    } catch (e) {
      // Secure storage operation failed, but continue initialization
      // This prevents the app from freezing if there are permission issues
      _log.severe('Failed to create app local storage: $e');
    }
  }

  Future<void> write(LocalStorageKey key, String value) async {
    try {
      await secureStorage.write(key: key.name, value: value);
    } catch (e) {
      // Secure storage write failed, but don't throw to prevent app crashes
      // This can happen on some devices with permission issues
      _log.severe('Failed to write to app local storage: $e');
    }
  }

  Future<String?> read(LocalStorageKey key) async {
    try {
      return await secureStorage.read(key: key.name);
    } catch (e) {
      // Secure storage read failed, return null to prevent app crashes
      _log.severe('Failed to read from app local storage: $e');
      return null;
    }
  }

  Future<void> delete(LocalStorageKey key) async {
    try {
      await secureStorage.delete(key: key.name);
    } catch (e) {
      // Secure storage delete failed, but don't throw to prevent app crashes
      _log.severe('Failed to delete from app local storage: $e');
    }
  }
}

enum LocalStorageKey {
  credentials,
  user,
  showProgression,
  showHighlights,
  tasksListView,
  progressionSelection,
  groupsListType,
}
