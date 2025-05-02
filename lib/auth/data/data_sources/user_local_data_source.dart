import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:task_master/app/storage/app_local_storage.dart';
import 'package:task_master/auth/data/models/user_data.dart';

class UserLocalDataSource {
  const UserLocalDataSource({required this.localStorage});

  @visibleForTesting
  final AppLocalStorage localStorage;

  Future<UserData?> load() async {
    final value = await localStorage.read(LocalStorageKey.user);

    if (value == null) {
      return null;
    }

    return UserData.fromJson(jsonDecode(value));
  }

  Future<void> save(UserData value) async {
    await localStorage.write(LocalStorageKey.user, jsonEncode(value.toJson()));
  }

  Future<void> delete() async {
    await localStorage.delete(LocalStorageKey.user);
  }
}
