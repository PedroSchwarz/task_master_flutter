import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:task_master/progress/progress.dart';

part 'progression_cubit.freezed.dart';

class ProgressionCubit extends Cubit<ProgressionState> {
  ProgressionCubit({required this.getTasksProgressionForWeeksUseCase})
    : super(const ProgressionState(isLoading: false, progression: [], period: ProgressionPeriod.oneMonth, isRefreshing: false));

  static final _log = Logger('ProgressionCubit');

  @visibleForTesting
  final GetTasksProgressionForWeeksUseCase getTasksProgressionForWeeksUseCase;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true));
    await loadProgression();
    emit(state.copyWith(isLoading: false));
  }

  Future<void> loadProgression({int weeks = 4}) async {
    try {
      final progression = await getTasksProgressionForWeeksUseCase(weeks: weeks);
      emit(state.copyWith(progression: progression));
    } catch (e) {
      _log.severe('Error loading progression: $e', e);
    }
  }

  Future<void> updatePeriod(ProgressionPeriod period) async {
    emit(state.copyWith(isRefreshing: true));

    emit(state.copyWith(period: period));

    await loadProgression(weeks: period.weeks);

    emit(state.copyWith(isRefreshing: false));
  }
}

@freezed
sealed class ProgressionState with _$ProgressionState {
  const factory ProgressionState({
    required bool isLoading,
    required List<WeeklyTaskProgression?> progression,
    required ProgressionPeriod period,
    required bool isRefreshing,
  }) = _ProgressionState;

  const ProgressionState._();

  double get maxTotal => progression.map((progression) => progression?.total ?? 0).max.toDouble();
}

enum ProgressionPeriod {
  oneMonth(weeks: 4),
  threeMonths(weeks: 12),
  sixMonths(weeks: 24),
  oneYear(weeks: 48);

  const ProgressionPeriod({required this.weeks});

  final int weeks;
}
