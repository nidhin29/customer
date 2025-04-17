// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 bool get isLoading; Option<Either<MainFailure, Model>> get isFailureOrSuccessForGet; Model? get profileModel;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForGet, isFailureOrSuccessForGet) || other.isFailureOrSuccessForGet == isFailureOrSuccessForGet)&&(identical(other.profileModel, profileModel) || other.profileModel == profileModel));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForGet,profileModel);

@override
String toString() {
  return 'ProfileState(isLoading: $isLoading, isFailureOrSuccessForGet: $isFailureOrSuccessForGet, profileModel: $profileModel)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Model>> isFailureOrSuccessForGet, Model? profileModel
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFailureOrSuccessForGet = null,Object? profileModel = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForGet: null == isFailureOrSuccessForGet ? _self.isFailureOrSuccessForGet : isFailureOrSuccessForGet // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Model>>,profileModel: freezed == profileModel ? _self.profileModel : profileModel // ignore: cast_nullable_to_non_nullable
as Model?,
  ));
}

}


/// @nodoc


class _Initial implements ProfileState {
  const _Initial({required this.isLoading, required this.isFailureOrSuccessForGet, required this.profileModel});
  

@override final  bool isLoading;
@override final  Option<Either<MainFailure, Model>> isFailureOrSuccessForGet;
@override final  Model? profileModel;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForGet, isFailureOrSuccessForGet) || other.isFailureOrSuccessForGet == isFailureOrSuccessForGet)&&(identical(other.profileModel, profileModel) || other.profileModel == profileModel));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForGet,profileModel);

@override
String toString() {
  return 'ProfileState(isLoading: $isLoading, isFailureOrSuccessForGet: $isFailureOrSuccessForGet, profileModel: $profileModel)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Model>> isFailureOrSuccessForGet, Model? profileModel
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFailureOrSuccessForGet = null,Object? profileModel = freezed,}) {
  return _then(_Initial(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForGet: null == isFailureOrSuccessForGet ? _self.isFailureOrSuccessForGet : isFailureOrSuccessForGet // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Model>>,profileModel: freezed == profileModel ? _self.profileModel : profileModel // ignore: cast_nullable_to_non_nullable
as Model?,
  ));
}


}

// dart format on
