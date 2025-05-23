// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progression_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressionState {

 bool get isLoading; List<WeeklyTaskProgression?> get progression; ProgressionPeriod get period; bool get isRefreshing;
/// Create a copy of ProgressionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressionStateCopyWith<ProgressionState> get copyWith => _$ProgressionStateCopyWithImpl<ProgressionState>(this as ProgressionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.progression, progression)&&(identical(other.period, period) || other.period == period)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(progression),period,isRefreshing);

@override
String toString() {
  return 'ProgressionState(isLoading: $isLoading, progression: $progression, period: $period, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class $ProgressionStateCopyWith<$Res>  {
  factory $ProgressionStateCopyWith(ProgressionState value, $Res Function(ProgressionState) _then) = _$ProgressionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<WeeklyTaskProgression?> progression, ProgressionPeriod period, bool isRefreshing
});




}
/// @nodoc
class _$ProgressionStateCopyWithImpl<$Res>
    implements $ProgressionStateCopyWith<$Res> {
  _$ProgressionStateCopyWithImpl(this._self, this._then);

  final ProgressionState _self;
  final $Res Function(ProgressionState) _then;

/// Create a copy of ProgressionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? progression = null,Object? period = null,Object? isRefreshing = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,progression: null == progression ? _self.progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ProgressionPeriod,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _ProgressionState extends ProgressionState {
  const _ProgressionState({required this.isLoading, required final  List<WeeklyTaskProgression?> progression, required this.period, required this.isRefreshing}): _progression = progression,super._();
  

@override final  bool isLoading;
 final  List<WeeklyTaskProgression?> _progression;
@override List<WeeklyTaskProgression?> get progression {
  if (_progression is EqualUnmodifiableListView) return _progression;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progression);
}

@override final  ProgressionPeriod period;
@override final  bool isRefreshing;

/// Create a copy of ProgressionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressionStateCopyWith<_ProgressionState> get copyWith => __$ProgressionStateCopyWithImpl<_ProgressionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._progression, _progression)&&(identical(other.period, period) || other.period == period)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_progression),period,isRefreshing);

@override
String toString() {
  return 'ProgressionState(isLoading: $isLoading, progression: $progression, period: $period, isRefreshing: $isRefreshing)';
}


}

/// @nodoc
abstract mixin class _$ProgressionStateCopyWith<$Res> implements $ProgressionStateCopyWith<$Res> {
  factory _$ProgressionStateCopyWith(_ProgressionState value, $Res Function(_ProgressionState) _then) = __$ProgressionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<WeeklyTaskProgression?> progression, ProgressionPeriod period, bool isRefreshing
});




}
/// @nodoc
class __$ProgressionStateCopyWithImpl<$Res>
    implements _$ProgressionStateCopyWith<$Res> {
  __$ProgressionStateCopyWithImpl(this._self, this._then);

  final _ProgressionState _self;
  final $Res Function(_ProgressionState) _then;

/// Create a copy of ProgressionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? progression = null,Object? period = null,Object? isRefreshing = null,}) {
  return _then(_ProgressionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,progression: null == progression ? _self._progression : progression // ignore: cast_nullable_to_non_nullable
as List<WeeklyTaskProgression?>,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as ProgressionPeriod,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
