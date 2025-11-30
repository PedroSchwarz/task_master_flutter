// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateTaskRequest {

 String get title; DateTime get dueDate; String get group; List<CreateTaskChecklistItem> get checklist; bool get recurring;@JsonKey(includeIfNull: false) String? get description;@JsonKey(includeIfNull: false) TaskPriority? get priority;@JsonKey(includeIfNull: false) TaskStatus? get status;@JsonKey(includeIfNull: false) List<String>? get assignedTo;@JsonKey(includeIfNull: false) TaskRecurrence? get recurrencePattern;@JsonKey(includeIfNull: false) DateTime? get recurrenceEndDate;
/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskRequestCopyWith<CreateTaskRequest> get copyWith => _$CreateTaskRequestCopyWithImpl<CreateTaskRequest>(this as CreateTaskRequest, _$identity);

  /// Serializes this CreateTaskRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.group, group) || other.group == group)&&const DeepCollectionEquality().equals(other.checklist, checklist)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.assignedTo, assignedTo)&&(identical(other.recurrencePattern, recurrencePattern) || other.recurrencePattern == recurrencePattern)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,group,const DeepCollectionEquality().hash(checklist),recurring,description,priority,status,const DeepCollectionEquality().hash(assignedTo),recurrencePattern,recurrenceEndDate);

@override
String toString() {
  return 'CreateTaskRequest(title: $title, dueDate: $dueDate, group: $group, checklist: $checklist, recurring: $recurring, description: $description, priority: $priority, status: $status, assignedTo: $assignedTo, recurrencePattern: $recurrencePattern, recurrenceEndDate: $recurrenceEndDate)';
}


}

/// @nodoc
abstract mixin class $CreateTaskRequestCopyWith<$Res>  {
  factory $CreateTaskRequestCopyWith(CreateTaskRequest value, $Res Function(CreateTaskRequest) _then) = _$CreateTaskRequestCopyWithImpl;
@useResult
$Res call({
 String title, DateTime dueDate, String group, List<CreateTaskChecklistItem> checklist, bool recurring,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) TaskPriority? priority,@JsonKey(includeIfNull: false) TaskStatus? status,@JsonKey(includeIfNull: false) List<String>? assignedTo,@JsonKey(includeIfNull: false) TaskRecurrence? recurrencePattern,@JsonKey(includeIfNull: false) DateTime? recurrenceEndDate
});




}
/// @nodoc
class _$CreateTaskRequestCopyWithImpl<$Res>
    implements $CreateTaskRequestCopyWith<$Res> {
  _$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final CreateTaskRequest _self;
  final $Res Function(CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? dueDate = null,Object? group = null,Object? checklist = null,Object? recurring = null,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? assignedTo = freezed,Object? recurrencePattern = freezed,Object? recurrenceEndDate = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<CreateTaskChecklistItem>,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,assignedTo: freezed == assignedTo ? _self.assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>?,recurrencePattern: freezed == recurrencePattern ? _self.recurrencePattern : recurrencePattern // ignore: cast_nullable_to_non_nullable
as TaskRecurrence?,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTaskRequest].
extension CreateTaskRequestPatterns on CreateTaskRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTaskRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTaskRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateTaskRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTaskRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  DateTime dueDate,  String group,  List<CreateTaskChecklistItem> checklist,  bool recurring, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  TaskPriority? priority, @JsonKey(includeIfNull: false)  TaskStatus? status, @JsonKey(includeIfNull: false)  List<String>? assignedTo, @JsonKey(includeIfNull: false)  TaskRecurrence? recurrencePattern, @JsonKey(includeIfNull: false)  DateTime? recurrenceEndDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that.title,_that.dueDate,_that.group,_that.checklist,_that.recurring,_that.description,_that.priority,_that.status,_that.assignedTo,_that.recurrencePattern,_that.recurrenceEndDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  DateTime dueDate,  String group,  List<CreateTaskChecklistItem> checklist,  bool recurring, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  TaskPriority? priority, @JsonKey(includeIfNull: false)  TaskStatus? status, @JsonKey(includeIfNull: false)  List<String>? assignedTo, @JsonKey(includeIfNull: false)  TaskRecurrence? recurrencePattern, @JsonKey(includeIfNull: false)  DateTime? recurrenceEndDate)  $default,) {final _that = this;
switch (_that) {
case _CreateTaskRequest():
return $default(_that.title,_that.dueDate,_that.group,_that.checklist,_that.recurring,_that.description,_that.priority,_that.status,_that.assignedTo,_that.recurrencePattern,_that.recurrenceEndDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  DateTime dueDate,  String group,  List<CreateTaskChecklistItem> checklist,  bool recurring, @JsonKey(includeIfNull: false)  String? description, @JsonKey(includeIfNull: false)  TaskPriority? priority, @JsonKey(includeIfNull: false)  TaskStatus? status, @JsonKey(includeIfNull: false)  List<String>? assignedTo, @JsonKey(includeIfNull: false)  TaskRecurrence? recurrencePattern, @JsonKey(includeIfNull: false)  DateTime? recurrenceEndDate)?  $default,) {final _that = this;
switch (_that) {
case _CreateTaskRequest() when $default != null:
return $default(_that.title,_that.dueDate,_that.group,_that.checklist,_that.recurring,_that.description,_that.priority,_that.status,_that.assignedTo,_that.recurrencePattern,_that.recurrenceEndDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateTaskRequest implements CreateTaskRequest {
  const _CreateTaskRequest({required this.title, required this.dueDate, required this.group, required final  List<CreateTaskChecklistItem> checklist, required this.recurring, @JsonKey(includeIfNull: false) this.description, @JsonKey(includeIfNull: false) this.priority, @JsonKey(includeIfNull: false) this.status, @JsonKey(includeIfNull: false) final  List<String>? assignedTo, @JsonKey(includeIfNull: false) this.recurrencePattern, @JsonKey(includeIfNull: false) this.recurrenceEndDate}): _checklist = checklist,_assignedTo = assignedTo;
  factory _CreateTaskRequest.fromJson(Map<String, dynamic> json) => _$CreateTaskRequestFromJson(json);

@override final  String title;
@override final  DateTime dueDate;
@override final  String group;
 final  List<CreateTaskChecklistItem> _checklist;
@override List<CreateTaskChecklistItem> get checklist {
  if (_checklist is EqualUnmodifiableListView) return _checklist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_checklist);
}

@override final  bool recurring;
@override@JsonKey(includeIfNull: false) final  String? description;
@override@JsonKey(includeIfNull: false) final  TaskPriority? priority;
@override@JsonKey(includeIfNull: false) final  TaskStatus? status;
 final  List<String>? _assignedTo;
@override@JsonKey(includeIfNull: false) List<String>? get assignedTo {
  final value = _assignedTo;
  if (value == null) return null;
  if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(includeIfNull: false) final  TaskRecurrence? recurrencePattern;
@override@JsonKey(includeIfNull: false) final  DateTime? recurrenceEndDate;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskRequestCopyWith<_CreateTaskRequest> get copyWith => __$CreateTaskRequestCopyWithImpl<_CreateTaskRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTaskRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.group, group) || other.group == group)&&const DeepCollectionEquality().equals(other._checklist, _checklist)&&(identical(other.recurring, recurring) || other.recurring == recurring)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._assignedTo, _assignedTo)&&(identical(other.recurrencePattern, recurrencePattern) || other.recurrencePattern == recurrencePattern)&&(identical(other.recurrenceEndDate, recurrenceEndDate) || other.recurrenceEndDate == recurrenceEndDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,dueDate,group,const DeepCollectionEquality().hash(_checklist),recurring,description,priority,status,const DeepCollectionEquality().hash(_assignedTo),recurrencePattern,recurrenceEndDate);

@override
String toString() {
  return 'CreateTaskRequest(title: $title, dueDate: $dueDate, group: $group, checklist: $checklist, recurring: $recurring, description: $description, priority: $priority, status: $status, assignedTo: $assignedTo, recurrencePattern: $recurrencePattern, recurrenceEndDate: $recurrenceEndDate)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskRequestCopyWith<$Res> implements $CreateTaskRequestCopyWith<$Res> {
  factory _$CreateTaskRequestCopyWith(_CreateTaskRequest value, $Res Function(_CreateTaskRequest) _then) = __$CreateTaskRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, DateTime dueDate, String group, List<CreateTaskChecklistItem> checklist, bool recurring,@JsonKey(includeIfNull: false) String? description,@JsonKey(includeIfNull: false) TaskPriority? priority,@JsonKey(includeIfNull: false) TaskStatus? status,@JsonKey(includeIfNull: false) List<String>? assignedTo,@JsonKey(includeIfNull: false) TaskRecurrence? recurrencePattern,@JsonKey(includeIfNull: false) DateTime? recurrenceEndDate
});




}
/// @nodoc
class __$CreateTaskRequestCopyWithImpl<$Res>
    implements _$CreateTaskRequestCopyWith<$Res> {
  __$CreateTaskRequestCopyWithImpl(this._self, this._then);

  final _CreateTaskRequest _self;
  final $Res Function(_CreateTaskRequest) _then;

/// Create a copy of CreateTaskRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? dueDate = null,Object? group = null,Object? checklist = null,Object? recurring = null,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? assignedTo = freezed,Object? recurrencePattern = freezed,Object? recurrenceEndDate = freezed,}) {
  return _then(_CreateTaskRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self._checklist : checklist // ignore: cast_nullable_to_non_nullable
as List<CreateTaskChecklistItem>,recurring: null == recurring ? _self.recurring : recurring // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus?,assignedTo: freezed == assignedTo ? _self._assignedTo : assignedTo // ignore: cast_nullable_to_non_nullable
as List<String>?,recurrencePattern: freezed == recurrencePattern ? _self.recurrencePattern : recurrencePattern // ignore: cast_nullable_to_non_nullable
as TaskRecurrence?,recurrenceEndDate: freezed == recurrenceEndDate ? _self.recurrenceEndDate : recurrenceEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateTaskChecklistItem {

 String get title; int get order;
/// Create a copy of CreateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTaskChecklistItemCopyWith<CreateTaskChecklistItem> get copyWith => _$CreateTaskChecklistItemCopyWithImpl<CreateTaskChecklistItem>(this as CreateTaskChecklistItem, _$identity);

  /// Serializes this CreateTaskChecklistItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTaskChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,order);

@override
String toString() {
  return 'CreateTaskChecklistItem(title: $title, order: $order)';
}


}

/// @nodoc
abstract mixin class $CreateTaskChecklistItemCopyWith<$Res>  {
  factory $CreateTaskChecklistItemCopyWith(CreateTaskChecklistItem value, $Res Function(CreateTaskChecklistItem) _then) = _$CreateTaskChecklistItemCopyWithImpl;
@useResult
$Res call({
 String title, int order
});




}
/// @nodoc
class _$CreateTaskChecklistItemCopyWithImpl<$Res>
    implements $CreateTaskChecklistItemCopyWith<$Res> {
  _$CreateTaskChecklistItemCopyWithImpl(this._self, this._then);

  final CreateTaskChecklistItem _self;
  final $Res Function(CreateTaskChecklistItem) _then;

/// Create a copy of CreateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? order = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTaskChecklistItem].
extension CreateTaskChecklistItemPatterns on CreateTaskChecklistItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTaskChecklistItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTaskChecklistItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTaskChecklistItem value)  $default,){
final _that = this;
switch (_that) {
case _CreateTaskChecklistItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTaskChecklistItem value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTaskChecklistItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTaskChecklistItem() when $default != null:
return $default(_that.title,_that.order);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  int order)  $default,) {final _that = this;
switch (_that) {
case _CreateTaskChecklistItem():
return $default(_that.title,_that.order);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  int order)?  $default,) {final _that = this;
switch (_that) {
case _CreateTaskChecklistItem() when $default != null:
return $default(_that.title,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateTaskChecklistItem implements CreateTaskChecklistItem {
  const _CreateTaskChecklistItem({required this.title, required this.order});
  factory _CreateTaskChecklistItem.fromJson(Map<String, dynamic> json) => _$CreateTaskChecklistItemFromJson(json);

@override final  String title;
@override final  int order;

/// Create a copy of CreateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTaskChecklistItemCopyWith<_CreateTaskChecklistItem> get copyWith => __$CreateTaskChecklistItemCopyWithImpl<_CreateTaskChecklistItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTaskChecklistItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTaskChecklistItem&&(identical(other.title, title) || other.title == title)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,order);

@override
String toString() {
  return 'CreateTaskChecklistItem(title: $title, order: $order)';
}


}

/// @nodoc
abstract mixin class _$CreateTaskChecklistItemCopyWith<$Res> implements $CreateTaskChecklistItemCopyWith<$Res> {
  factory _$CreateTaskChecklistItemCopyWith(_CreateTaskChecklistItem value, $Res Function(_CreateTaskChecklistItem) _then) = __$CreateTaskChecklistItemCopyWithImpl;
@override @useResult
$Res call({
 String title, int order
});




}
/// @nodoc
class __$CreateTaskChecklistItemCopyWithImpl<$Res>
    implements _$CreateTaskChecklistItemCopyWith<$Res> {
  __$CreateTaskChecklistItemCopyWithImpl(this._self, this._then);

  final _CreateTaskChecklistItem _self;
  final $Res Function(_CreateTaskChecklistItem) _then;

/// Create a copy of CreateTaskChecklistItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? order = null,}) {
  return _then(_CreateTaskChecklistItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
