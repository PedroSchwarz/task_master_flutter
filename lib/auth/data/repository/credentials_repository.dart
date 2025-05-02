import 'package:flutter/material.dart';
import 'package:task_master/auth/data/data_sources/credentials_local_data_source.dart';
import 'package:task_master/auth/data/models/credentials_data.dart';

class CredentialsRepository {
  const CredentialsRepository({required this.credentialsLocalDataSource});

  @visibleForTesting
  final CredentialsLocalDataSource credentialsLocalDataSource;

  Future<CredentialsData?> getCredentials() async {
    return credentialsLocalDataSource.load();
  }

  Future<void> updateCredentials(CredentialsData? value) async {
    if (value == null) {
      await credentialsLocalDataSource.delete();
    } else {
      await credentialsLocalDataSource.save(value);
    }
  }
}
