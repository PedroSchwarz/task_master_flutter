import 'package:flutter/foundation.dart';
import 'package:task_master/auth/auth.dart';

class GetUsersCurrentWeekUseCase {
  const GetUsersCurrentWeekUseCase({required this.authRepository});

  @visibleForTesting
  final AuthRepository authRepository;

  int call() {
    final user = authRepository.currentUser.valueOrNull;

    if (user == null) {
      return 0;
    }

    final now = DateTime.now();
    final difference = now.difference(user.createdAt.toLocal()).inDays;

    return (difference ~/ 7) + 1;
  }
}
