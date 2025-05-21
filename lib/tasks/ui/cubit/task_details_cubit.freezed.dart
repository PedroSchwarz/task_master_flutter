// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskDetailsState {

 bool get isLoading; bool get showDeleteDialog; bool get shouldGoBack; List<CommentResponse> get comments; String get comment; bool get isRefreshing; bool get isLoadingComments; TaskResponse? get task;
/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailsStateCopyWith<TaskDetailsState> get copyWith => _$TaskDetailsStateCopyWithImpl<TaskDetailsState>(this as TaskDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showDeleteDialog, showDeleteDialog) || other.showDeleteDialog == showDeleteDialog)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingComments, isLoadingComments) || other.isLoadingComments == isLoadingComments)&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,showDeleteDialog,shouldGoBack,const DeepCollectionEquality().hash(comments),comment,isRefreshing,isLoadingComments,task);

@override
String toString() {
  return 'TaskDetailsState(isLoading: $isLoading, showDeleteDialog: $showDeleteDialog, shouldGoBack: $shouldGoBack, comments: $comments, comment: $comment, isRefreshing: $isRefreshing, isLoadingComments: $isLoadingComments, task: $task)';
}


}

/// @nodoc
abstract mixin class $TaskDetailsStateCopyWith<$Res>  {
  factory $TaskDetailsStateCopyWith(TaskDetailsState value, $Res Function(TaskDetailsState) _then) = _$TaskDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool showDeleteDialog, bool shouldGoBack, List<CommentResponse> comments, String comment, bool isRefreshing, bool isLoadingComments, TaskResponse? task
});


$TaskResponseCopyWith<$Res>? get task;

}
/// @nodoc
class _$TaskDetailsStateCopyWithImpl<$Res>
    implements $TaskDetailsStateCopyWith<$Res> {
  _$TaskDetailsStateCopyWithImpl(this._self, this._then);

  final TaskDetailsState _self;
  final $Res Function(TaskDetailsState) _then;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? showDeleteDialog = null,Object? shouldGoBack = null,Object? comments = null,Object? comment = null,Object? isRefreshing = null,Object? isLoadingComments = null,Object? task = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showDeleteDialog: null == showDeleteDialog ? _self.showDeleteDialog : showDeleteDialog // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentResponse>,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingComments: null == isLoadingComments ? _self.isLoadingComments : isLoadingComments // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}
/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}


/// @nodoc


class _TaskDetailsState extends TaskDetailsState {
  const _TaskDetailsState({required this.isLoading, required this.showDeleteDialog, required this.shouldGoBack, required final  List<CommentResponse> comments, required this.comment, required this.isRefreshing, required this.isLoadingComments, this.task}): _comments = comments,super._();
  

@override final  bool isLoading;
@override final  bool showDeleteDialog;
@override final  bool shouldGoBack;
 final  List<CommentResponse> _comments;
@override List<CommentResponse> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override final  String comment;
@override final  bool isRefreshing;
@override final  bool isLoadingComments;
@override final  TaskResponse? task;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskDetailsStateCopyWith<_TaskDetailsState> get copyWith => __$TaskDetailsStateCopyWithImpl<_TaskDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.showDeleteDialog, showDeleteDialog) || other.showDeleteDialog == showDeleteDialog)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingComments, isLoadingComments) || other.isLoadingComments == isLoadingComments)&&(identical(other.task, task) || other.task == task));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,showDeleteDialog,shouldGoBack,const DeepCollectionEquality().hash(_comments),comment,isRefreshing,isLoadingComments,task);

@override
String toString() {
  return 'TaskDetailsState(isLoading: $isLoading, showDeleteDialog: $showDeleteDialog, shouldGoBack: $shouldGoBack, comments: $comments, comment: $comment, isRefreshing: $isRefreshing, isLoadingComments: $isLoadingComments, task: $task)';
}


}

/// @nodoc
abstract mixin class _$TaskDetailsStateCopyWith<$Res> implements $TaskDetailsStateCopyWith<$Res> {
  factory _$TaskDetailsStateCopyWith(_TaskDetailsState value, $Res Function(_TaskDetailsState) _then) = __$TaskDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool showDeleteDialog, bool shouldGoBack, List<CommentResponse> comments, String comment, bool isRefreshing, bool isLoadingComments, TaskResponse? task
});


@override $TaskResponseCopyWith<$Res>? get task;

}
/// @nodoc
class __$TaskDetailsStateCopyWithImpl<$Res>
    implements _$TaskDetailsStateCopyWith<$Res> {
  __$TaskDetailsStateCopyWithImpl(this._self, this._then);

  final _TaskDetailsState _self;
  final $Res Function(_TaskDetailsState) _then;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? showDeleteDialog = null,Object? shouldGoBack = null,Object? comments = null,Object? comment = null,Object? isRefreshing = null,Object? isLoadingComments = null,Object? task = freezed,}) {
  return _then(_TaskDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,showDeleteDialog: null == showDeleteDialog ? _self.showDeleteDialog : showDeleteDialog // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<CommentResponse>,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingComments: null == isLoadingComments ? _self.isLoadingComments : isLoadingComments // ignore: cast_nullable_to_non_nullable
as bool,task: freezed == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as TaskResponse?,
  ));
}

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskResponseCopyWith<$Res>? get task {
    if (_self.task == null) {
    return null;
  }

  return $TaskResponseCopyWith<$Res>(_self.task!, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

// dart format on
