// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignupState {

 bool get isLoading; Option<Either<MainFailure, Unit>> get isFailureOrSuccess;
/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupStateCopyWith<SignupState> get copyWith => _$SignupStateCopyWithImpl<SignupState>(this as SignupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccess, isFailureOrSuccess) || other.isFailureOrSuccess == isFailureOrSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccess);

@override
String toString() {
  return 'SignupState(isLoading: $isLoading, isFailureOrSuccess: $isFailureOrSuccess)';
}


}

/// @nodoc
abstract mixin class $SignupStateCopyWith<$Res>  {
  factory $SignupStateCopyWith(SignupState value, $Res Function(SignupState) _then) = _$SignupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Unit>> isFailureOrSuccess
});




}
/// @nodoc
class _$SignupStateCopyWithImpl<$Res>
    implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._self, this._then);

  final SignupState _self;
  final $Res Function(SignupState) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFailureOrSuccess = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccess: null == isFailureOrSuccess ? _self.isFailureOrSuccess : isFailureOrSuccess // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,
  ));
}

}


/// @nodoc


class _SigninState implements SignupState {
  const _SigninState({required this.isLoading, required this.isFailureOrSuccess});
  

@override final  bool isLoading;
@override final  Option<Either<MainFailure, Unit>> isFailureOrSuccess;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SigninStateCopyWith<_SigninState> get copyWith => __$SigninStateCopyWithImpl<_SigninState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SigninState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccess, isFailureOrSuccess) || other.isFailureOrSuccess == isFailureOrSuccess));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccess);

@override
String toString() {
  return 'SignupState(isLoading: $isLoading, isFailureOrSuccess: $isFailureOrSuccess)';
}


}

/// @nodoc
abstract mixin class _$SigninStateCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory _$SigninStateCopyWith(_SigninState value, $Res Function(_SigninState) _then) = __$SigninStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, Unit>> isFailureOrSuccess
});




}
/// @nodoc
class __$SigninStateCopyWithImpl<$Res>
    implements _$SigninStateCopyWith<$Res> {
  __$SigninStateCopyWithImpl(this._self, this._then);

  final _SigninState _self;
  final $Res Function(_SigninState) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFailureOrSuccess = null,}) {
  return _then(_SigninState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccess: null == isFailureOrSuccess ? _self.isFailureOrSuccess : isFailureOrSuccess // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,
  ));
}


}

// dart format on
