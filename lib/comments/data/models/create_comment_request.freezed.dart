// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_comment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateCommentRequest {

 String get message; String get task;
/// Create a copy of CreateCommentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateCommentRequestCopyWith<CreateCommentRequest> get copyWith => _$CreateCommentRequestCopyWithImpl<CreateCommentRequest>(this as CreateCommentRequest, _$identity);

  /// Serializes this CreateCommentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateCommentRequest&&(identical(other.message, message) || other.message == message)&&(identical(other.task, task) || other.task == task));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,task);

@override
String toString() {
  return 'CreateCommentRequest(message: $message, task: $task)';
}


}

/// @nodoc
abstract mixin class $CreateCommentRequestCopyWith<$Res>  {
  factory $CreateCommentRequestCopyWith(CreateCommentRequest value, $Res Function(CreateCommentRequest) _then) = _$CreateCommentRequestCopyWithImpl;
@useResult
$Res call({
 String message, String task
});




}
/// @nodoc
class _$CreateCommentRequestCopyWithImpl<$Res>
    implements $CreateCommentRequestCopyWith<$Res> {
  _$CreateCommentRequestCopyWithImpl(this._self, this._then);

  final CreateCommentRequest _self;
  final $Res Function(CreateCommentRequest) _then;

/// Create a copy of CreateCommentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? task = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _CreateCommentRequest implements CreateCommentRequest {
  const _CreateCommentRequest({required this.message, required this.task});
  factory _CreateCommentRequest.fromJson(Map<String, dynamic> json) => _$CreateCommentRequestFromJson(json);

@override final  String message;
@override final  String task;

/// Create a copy of CreateCommentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateCommentRequestCopyWith<_CreateCommentRequest> get copyWith => __$CreateCommentRequestCopyWithImpl<_CreateCommentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateCommentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateCommentRequest&&(identical(other.message, message) || other.message == message)&&(identical(other.task, task) || other.task == task));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,task);

@override
String toString() {
  return 'CreateCommentRequest(message: $message, task: $task)';
}


}

/// @nodoc
abstract mixin class _$CreateCommentRequestCopyWith<$Res> implements $CreateCommentRequestCopyWith<$Res> {
  factory _$CreateCommentRequestCopyWith(_CreateCommentRequest value, $Res Function(_CreateCommentRequest) _then) = __$CreateCommentRequestCopyWithImpl;
@override @useResult
$Res call({
 String message, String task
});




}
/// @nodoc
class __$CreateCommentRequestCopyWithImpl<$Res>
    implements _$CreateCommentRequestCopyWith<$Res> {
  __$CreateCommentRequestCopyWithImpl(this._self, this._then);

  final _CreateCommentRequest _self;
  final $Res Function(_CreateCommentRequest) _then;

/// Create a copy of CreateCommentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? task = null,}) {
  return _then(_CreateCommentRequest(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,task: null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
