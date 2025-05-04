// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_group_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateGroupState {

 List<UserResponse> get users; List<String> get selectedUsersIds; String get name; String get description; bool get showInviteUsersSheet; bool get isLoading; bool get shouldGoBack;
/// Create a copy of CreateGroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGroupStateCopyWith<CreateGroupState> get copyWith => _$CreateGroupStateCopyWithImpl<CreateGroupState>(this as CreateGroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGroupState&&const DeepCollectionEquality().equals(other.users, users)&&const DeepCollectionEquality().equals(other.selectedUsersIds, selectedUsersIds)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.showInviteUsersSheet, showInviteUsersSheet) || other.showInviteUsersSheet == showInviteUsersSheet)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(users),const DeepCollectionEquality().hash(selectedUsersIds),name,description,showInviteUsersSheet,isLoading,shouldGoBack);

@override
String toString() {
  return 'CreateGroupState(users: $users, selectedUsersIds: $selectedUsersIds, name: $name, description: $description, showInviteUsersSheet: $showInviteUsersSheet, isLoading: $isLoading, shouldGoBack: $shouldGoBack)';
}


}

/// @nodoc
abstract mixin class $CreateGroupStateCopyWith<$Res>  {
  factory $CreateGroupStateCopyWith(CreateGroupState value, $Res Function(CreateGroupState) _then) = _$CreateGroupStateCopyWithImpl;
@useResult
$Res call({
 List<UserResponse> users, List<String> selectedUsersIds, String name, String description, bool showInviteUsersSheet, bool isLoading, bool shouldGoBack
});




}
/// @nodoc
class _$CreateGroupStateCopyWithImpl<$Res>
    implements $CreateGroupStateCopyWith<$Res> {
  _$CreateGroupStateCopyWithImpl(this._self, this._then);

  final CreateGroupState _self;
  final $Res Function(CreateGroupState) _then;

/// Create a copy of CreateGroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? users = null,Object? selectedUsersIds = null,Object? name = null,Object? description = null,Object? showInviteUsersSheet = null,Object? isLoading = null,Object? shouldGoBack = null,}) {
  return _then(_self.copyWith(
users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserResponse>,selectedUsersIds: null == selectedUsersIds ? _self.selectedUsersIds : selectedUsersIds // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,showInviteUsersSheet: null == showInviteUsersSheet ? _self.showInviteUsersSheet : showInviteUsersSheet // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _CreateGroupState extends CreateGroupState {
  const _CreateGroupState({required final  List<UserResponse> users, required final  List<String> selectedUsersIds, required this.name, required this.description, required this.showInviteUsersSheet, required this.isLoading, required this.shouldGoBack}): _users = users,_selectedUsersIds = selectedUsersIds,super._();
  

 final  List<UserResponse> _users;
@override List<UserResponse> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}

 final  List<String> _selectedUsersIds;
@override List<String> get selectedUsersIds {
  if (_selectedUsersIds is EqualUnmodifiableListView) return _selectedUsersIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedUsersIds);
}

@override final  String name;
@override final  String description;
@override final  bool showInviteUsersSheet;
@override final  bool isLoading;
@override final  bool shouldGoBack;

/// Create a copy of CreateGroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGroupStateCopyWith<_CreateGroupState> get copyWith => __$CreateGroupStateCopyWithImpl<_CreateGroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGroupState&&const DeepCollectionEquality().equals(other._users, _users)&&const DeepCollectionEquality().equals(other._selectedUsersIds, _selectedUsersIds)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.showInviteUsersSheet, showInviteUsersSheet) || other.showInviteUsersSheet == showInviteUsersSheet)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.shouldGoBack, shouldGoBack) || other.shouldGoBack == shouldGoBack));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_users),const DeepCollectionEquality().hash(_selectedUsersIds),name,description,showInviteUsersSheet,isLoading,shouldGoBack);

@override
String toString() {
  return 'CreateGroupState(users: $users, selectedUsersIds: $selectedUsersIds, name: $name, description: $description, showInviteUsersSheet: $showInviteUsersSheet, isLoading: $isLoading, shouldGoBack: $shouldGoBack)';
}


}

/// @nodoc
abstract mixin class _$CreateGroupStateCopyWith<$Res> implements $CreateGroupStateCopyWith<$Res> {
  factory _$CreateGroupStateCopyWith(_CreateGroupState value, $Res Function(_CreateGroupState) _then) = __$CreateGroupStateCopyWithImpl;
@override @useResult
$Res call({
 List<UserResponse> users, List<String> selectedUsersIds, String name, String description, bool showInviteUsersSheet, bool isLoading, bool shouldGoBack
});




}
/// @nodoc
class __$CreateGroupStateCopyWithImpl<$Res>
    implements _$CreateGroupStateCopyWith<$Res> {
  __$CreateGroupStateCopyWithImpl(this._self, this._then);

  final _CreateGroupState _self;
  final $Res Function(_CreateGroupState) _then;

/// Create a copy of CreateGroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? users = null,Object? selectedUsersIds = null,Object? name = null,Object? description = null,Object? showInviteUsersSheet = null,Object? isLoading = null,Object? shouldGoBack = null,}) {
  return _then(_CreateGroupState(
users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserResponse>,selectedUsersIds: null == selectedUsersIds ? _self._selectedUsersIds : selectedUsersIds // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,showInviteUsersSheet: null == showInviteUsersSheet ? _self.showInviteUsersSheet : showInviteUsersSheet // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,shouldGoBack: null == shouldGoBack ? _self.shouldGoBack : shouldGoBack // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
