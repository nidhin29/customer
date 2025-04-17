// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ViewState {

 bool get isLoading; Option<Either<MainFailure, StaffModel>> get isFailureorSuccess; Option<Either<MainFailure, DetailModel>> get isFailureorSuccessForDetail; Option<Either<MainFailure, TeamModel>> get isFailureorSuccessForTeam;
/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ViewStateCopyWith<ViewState> get copyWith => _$ViewStateCopyWithImpl<ViewState>(this as ViewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ViewState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureorSuccess, isFailureorSuccess) || other.isFailureorSuccess == isFailureorSuccess)&&(identical(other.isFailureorSuccessForDetail, isFailureorSuccessForDetail) || other.isFailureorSuccessForDetail == isFailureorSuccessForDetail)&&(identical(other.isFailureorSuccessForTeam, isFailureorSuccessForTeam) || other.isFailureorSuccessForTeam == isFailureorSuccessForTeam));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureorSuccess,isFailureorSuccessForDetail,isFailureorSuccessForTeam);

@override
String toString() {
  return 'ViewState(isLoading: $isLoading, isFailureorSuccess: $isFailureorSuccess, isFailureorSuccessForDetail: $isFailureorSuccessForDetail, isFailureorSuccessForTeam: $isFailureorSuccessForTeam)';
}


}

/// @nodoc
abstract mixin class $ViewStateCopyWith<$Res>  {
  factory $ViewStateCopyWith(ViewState value, $Res Function(ViewState) _then) = _$ViewStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, StaffModel>> isFailureorSuccess, Option<Either<MainFailure, DetailModel>> isFailureorSuccessForDetail, Option<Either<MainFailure, TeamModel>> isFailureorSuccessForTeam
});




}
/// @nodoc
class _$ViewStateCopyWithImpl<$Res>
    implements $ViewStateCopyWith<$Res> {
  _$ViewStateCopyWithImpl(this._self, this._then);

  final ViewState _self;
  final $Res Function(ViewState) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFailureorSuccess = null,Object? isFailureorSuccessForDetail = null,Object? isFailureorSuccessForTeam = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureorSuccess: null == isFailureorSuccess ? _self.isFailureorSuccess : isFailureorSuccess // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, StaffModel>>,isFailureorSuccessForDetail: null == isFailureorSuccessForDetail ? _self.isFailureorSuccessForDetail : isFailureorSuccessForDetail // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, DetailModel>>,isFailureorSuccessForTeam: null == isFailureorSuccessForTeam ? _self.isFailureorSuccessForTeam : isFailureorSuccessForTeam // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, TeamModel>>,
  ));
}

}


/// @nodoc


class _Initial implements ViewState {
  const _Initial({required this.isLoading, required this.isFailureorSuccess, required this.isFailureorSuccessForDetail, required this.isFailureorSuccessForTeam});
  

@override final  bool isLoading;
@override final  Option<Either<MainFailure, StaffModel>> isFailureorSuccess;
@override final  Option<Either<MainFailure, DetailModel>> isFailureorSuccessForDetail;
@override final  Option<Either<MainFailure, TeamModel>> isFailureorSuccessForTeam;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureorSuccess, isFailureorSuccess) || other.isFailureorSuccess == isFailureorSuccess)&&(identical(other.isFailureorSuccessForDetail, isFailureorSuccessForDetail) || other.isFailureorSuccessForDetail == isFailureorSuccessForDetail)&&(identical(other.isFailureorSuccessForTeam, isFailureorSuccessForTeam) || other.isFailureorSuccessForTeam == isFailureorSuccessForTeam));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureorSuccess,isFailureorSuccessForDetail,isFailureorSuccessForTeam);

@override
String toString() {
  return 'ViewState(isLoading: $isLoading, isFailureorSuccess: $isFailureorSuccess, isFailureorSuccessForDetail: $isFailureorSuccessForDetail, isFailureorSuccessForTeam: $isFailureorSuccessForTeam)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $ViewStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, StaffModel>> isFailureorSuccess, Option<Either<MainFailure, DetailModel>> isFailureorSuccessForDetail, Option<Either<MainFailure, TeamModel>> isFailureorSuccessForTeam
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of ViewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFailureorSuccess = null,Object? isFailureorSuccessForDetail = null,Object? isFailureorSuccessForTeam = null,}) {
  return _then(_Initial(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureorSuccess: null == isFailureorSuccess ? _self.isFailureorSuccess : isFailureorSuccess // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, StaffModel>>,isFailureorSuccessForDetail: null == isFailureorSuccessForDetail ? _self.isFailureorSuccessForDetail : isFailureorSuccessForDetail // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, DetailModel>>,isFailureorSuccessForTeam: null == isFailureorSuccessForTeam ? _self.isFailureorSuccessForTeam : isFailureorSuccessForTeam // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, TeamModel>>,
  ));
}


}

// dart format on
