// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_task_progression.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeeklyTaskProgression {

 int get week; DateTime get startDate; DateTime get endDate; int get completed; int get total; int get overdue; List<SimplifiedTaskResponse> get tasks;
/// Create a copy of WeeklyTaskProgression
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyTaskProgressionCopyWith<WeeklyTaskProgression> get copyWith => _$WeeklyTaskProgressionCopyWithImpl<WeeklyTaskProgression>(this as WeeklyTaskProgression, _$identity);

  /// Serializes this WeeklyTaskProgression to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyTaskProgression&&(identical(other.week, week) || other.week == week)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.total, total) || other.total == total)&&(identical(other.overdue, overdue) || other.overdue == overdue)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,startDate,endDate,completed,total,overdue,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'WeeklyTaskProgression(week: $week, startDate: $startDate, endDate: $endDate, completed: $completed, total: $total, overdue: $overdue, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $WeeklyTaskProgressionCopyWith<$Res>  {
  factory $WeeklyTaskProgressionCopyWith(WeeklyTaskProgression value, $Res Function(WeeklyTaskProgression) _then) = _$WeeklyTaskProgressionCopyWithImpl;
@useResult
$Res call({
 int week, DateTime startDate, DateTime endDate, int completed, int total, int overdue, List<SimplifiedTaskResponse> tasks
});




}
/// @nodoc
class _$WeeklyTaskProgressionCopyWithImpl<$Res>
    implements $WeeklyTaskProgressionCopyWith<$Res> {
  _$WeeklyTaskProgressionCopyWithImpl(this._self, this._then);

  final WeeklyTaskProgression _self;
  final $Res Function(WeeklyTaskProgression) _then;

/// Create a copy of WeeklyTaskProgression
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = null,Object? startDate = null,Object? endDate = null,Object? completed = null,Object? total = null,Object? overdue = null,Object? tasks = null,}) {
  return _then(_self.copyWith(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<SimplifiedTaskResponse>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeeklyTaskProgression extends WeeklyTaskProgression {
  const _WeeklyTaskProgression({required this.week, required this.startDate, required this.endDate, required this.completed, required this.total, required this.overdue, required final  List<SimplifiedTaskResponse> tasks}): _tasks = tasks,super._();
  factory _WeeklyTaskProgression.fromJson(Map<String, dynamic> json) => _$WeeklyTaskProgressionFromJson(json);

@override final  int week;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int completed;
@override final  int total;
@override final  int overdue;
 final  List<SimplifiedTaskResponse> _tasks;
@override List<SimplifiedTaskResponse> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of WeeklyTaskProgression
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyTaskProgressionCopyWith<_WeeklyTaskProgression> get copyWith => __$WeeklyTaskProgressionCopyWithImpl<_WeeklyTaskProgression>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyTaskProgressionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyTaskProgression&&(identical(other.week, week) || other.week == week)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.total, total) || other.total == total)&&(identical(other.overdue, overdue) || other.overdue == overdue)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,startDate,endDate,completed,total,overdue,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'WeeklyTaskProgression(week: $week, startDate: $startDate, endDate: $endDate, completed: $completed, total: $total, overdue: $overdue, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$WeeklyTaskProgressionCopyWith<$Res> implements $WeeklyTaskProgressionCopyWith<$Res> {
  factory _$WeeklyTaskProgressionCopyWith(_WeeklyTaskProgression value, $Res Function(_WeeklyTaskProgression) _then) = __$WeeklyTaskProgressionCopyWithImpl;
@override @useResult
$Res call({
 int week, DateTime startDate, DateTime endDate, int completed, int total, int overdue, List<SimplifiedTaskResponse> tasks
});




}
/// @nodoc
class __$WeeklyTaskProgressionCopyWithImpl<$Res>
    implements _$WeeklyTaskProgressionCopyWith<$Res> {
  __$WeeklyTaskProgressionCopyWithImpl(this._self, this._then);

  final _WeeklyTaskProgression _self;
  final $Res Function(_WeeklyTaskProgression) _then;

/// Create a copy of WeeklyTaskProgression
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? week = null,Object? startDate = null,Object? endDate = null,Object? completed = null,Object? total = null,Object? overdue = null,Object? tasks = null,}) {
  return _then(_WeeklyTaskProgression(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,overdue: null == overdue ? _self.overdue : overdue // ignore: cast_nullable_to_non_nullable
as int,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<SimplifiedTaskResponse>,
  ));
}


}

// dart format on
