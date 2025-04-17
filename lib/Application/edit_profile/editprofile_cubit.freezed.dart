// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editprofile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditprofileState {

 bool get isLoading; Option<Either<MainFailure, Unit>> get isFailureOrSuccessForUpdate;
/// Create a copy of EditprofileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditprofileStateCopyWith<EditprofileState> get copyWith => _$EditprofileStateCopyWithImpl<EditprofileState>(this as EditprofileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditprofileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForUpdate, isFailureOrSuccessForUpdate) || other.isFailureOrSuccessForUpdate == isFailureOrSuccessForUpdate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForUpdate);

@override
String toString() {
  return 'EditprofileState(isLoading: $isLoading, isFailureOrSuccessForUpdate: $isFailureOrSuccessForUpdate)';
}


}

/// @nodoc
abstract mixin class $EditprofileStateCopyWith<$Res>  {
  factory $EditprofileStateCopyWith(EditprofileState value, $Res Function(EditprofileState) _then) = _$EditprofileStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Unit>> isFailureOrSuccessForUpdate
});




}
/// @nodoc
class _$EditprofileStateCopyWithImpl<$Res>
    implements $EditprofileStateCopyWith<$Res> {
  _$EditprofileStateCopyWithImpl(this._self, this._then);

  final EditprofileState _self;
  final $Res Function(EditprofileState) _then;

/// Create a copy of EditprofileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFailureOrSuccessForUpdate = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForUpdate: null == isFailureOrSuccessForUpdate ? _self.isFailureOrSuccessForUpdate : isFailureOrSuccessForUpdate // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,
  ));
}

}


/// @nodoc


class _Initial implements EditprofileState {
  const _Initial({required this.isLoading, required this.isFailureOrSuccessForUpdate});
  

@override final  bool isLoading;
@override final  Option<Either<MainFailure, Unit>> isFailureOrSuccessForUpdate;

/// Create a copy of EditprofileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForUpdate, isFailureOrSuccessForUpdate) || other.isFailureOrSuccessForUpdate == isFailureOrSuccessForUpdate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForUpdate);

@override
String toString() {
  return 'EditprofileState(isLoading: $isLoading, isFailureOrSuccessForUpdate: $isFailureOrSuccessForUpdate)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $EditprofileStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Unit>> isFailureOrSuccessForUpdate
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of EditprofileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFailureOrSuccessForUpdate = null,}) {
  return _then(_Initial(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForUpdate: null == isFailureOrSuccessForUpdate ? _self.isFailureOrSuccessForUpdate : isFailureOrSuccessForUpdate // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,
  ));
}


}

// dart format on
