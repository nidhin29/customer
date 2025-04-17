// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageState {

 bool get isLoading; Option<Either<MainFailure, List<ChatsView>>> get isFailureOrSuccessForViewMessage; Option<Either<MainFailure, Unit>> get isFailureOrSuccessForSendMessage; List<ChatsView>? get chats; Set<int> get displayedMessageIds; Set<String> get displayedMessageKeys; String? get currentEmail;
/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageStateCopyWith<MessageState> get copyWith => _$MessageStateCopyWithImpl<MessageState>(this as MessageState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForViewMessage, isFailureOrSuccessForViewMessage) || other.isFailureOrSuccessForViewMessage == isFailureOrSuccessForViewMessage)&&(identical(other.isFailureOrSuccessForSendMessage, isFailureOrSuccessForSendMessage) || other.isFailureOrSuccessForSendMessage == isFailureOrSuccessForSendMessage)&&const DeepCollectionEquality().equals(other.chats, chats)&&const DeepCollectionEquality().equals(other.displayedMessageIds, displayedMessageIds)&&const DeepCollectionEquality().equals(other.displayedMessageKeys, displayedMessageKeys)&&(identical(other.currentEmail, currentEmail) || other.currentEmail == currentEmail));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForViewMessage,isFailureOrSuccessForSendMessage,const DeepCollectionEquality().hash(chats),const DeepCollectionEquality().hash(displayedMessageIds),const DeepCollectionEquality().hash(displayedMessageKeys),currentEmail);

@override
String toString() {
  return 'MessageState(isLoading: $isLoading, isFailureOrSuccessForViewMessage: $isFailureOrSuccessForViewMessage, isFailureOrSuccessForSendMessage: $isFailureOrSuccessForSendMessage, chats: $chats, displayedMessageIds: $displayedMessageIds, displayedMessageKeys: $displayedMessageKeys, currentEmail: $currentEmail)';
}


}

/// @nodoc
abstract mixin class $MessageStateCopyWith<$Res>  {
  factory $MessageStateCopyWith(MessageState value, $Res Function(MessageState) _then) = _$MessageStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, List<ChatsView>>> isFailureOrSuccessForViewMessage, Option<Either<MainFailure, Unit>> isFailureOrSuccessForSendMessage, List<ChatsView>? chats, Set<int> displayedMessageIds, Set<String> displayedMessageKeys, String? currentEmail
});




}
/// @nodoc
class _$MessageStateCopyWithImpl<$Res>
    implements $MessageStateCopyWith<$Res> {
  _$MessageStateCopyWithImpl(this._self, this._then);

  final MessageState _self;
  final $Res Function(MessageState) _then;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFailureOrSuccessForViewMessage = null,Object? isFailureOrSuccessForSendMessage = null,Object? chats = freezed,Object? displayedMessageIds = null,Object? displayedMessageKeys = null,Object? currentEmail = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForViewMessage: null == isFailureOrSuccessForViewMessage ? _self.isFailureOrSuccessForViewMessage : isFailureOrSuccessForViewMessage // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, List<ChatsView>>>,isFailureOrSuccessForSendMessage: null == isFailureOrSuccessForSendMessage ? _self.isFailureOrSuccessForSendMessage : isFailureOrSuccessForSendMessage // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,chats: freezed == chats ? _self.chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatsView>?,displayedMessageIds: null == displayedMessageIds ? _self.displayedMessageIds : displayedMessageIds // ignore: cast_nullable_to_non_nullable
as Set<int>,displayedMessageKeys: null == displayedMessageKeys ? _self.displayedMessageKeys : displayedMessageKeys // ignore: cast_nullable_to_non_nullable
as Set<String>,currentEmail: freezed == currentEmail ? _self.currentEmail : currentEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc


class _Initial implements MessageState {
  const _Initial({required this.isLoading, required this.isFailureOrSuccessForViewMessage, required this.isFailureOrSuccessForSendMessage, required final  List<ChatsView>? chats, required final  Set<int> displayedMessageIds, required final  Set<String> displayedMessageKeys, required this.currentEmail}): _chats = chats,_displayedMessageIds = displayedMessageIds,_displayedMessageKeys = displayedMessageKeys;
  

@override final  bool isLoading;
@override final  Option<Either<MainFailure, List<ChatsView>>> isFailureOrSuccessForViewMessage;
@override final  Option<Either<MainFailure, Unit>> isFailureOrSuccessForSendMessage;
 final  List<ChatsView>? _chats;
@override List<ChatsView>? get chats {
  final value = _chats;
  if (value == null) return null;
  if (_chats is EqualUnmodifiableListView) return _chats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Set<int> _displayedMessageIds;
@override Set<int> get displayedMessageIds {
  if (_displayedMessageIds is EqualUnmodifiableSetView) return _displayedMessageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_displayedMessageIds);
}

 final  Set<String> _displayedMessageKeys;
@override Set<String> get displayedMessageKeys {
  if (_displayedMessageKeys is EqualUnmodifiableSetView) return _displayedMessageKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_displayedMessageKeys);
}

@override final  String? currentEmail;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFailureOrSuccessForViewMessage, isFailureOrSuccessForViewMessage) || other.isFailureOrSuccessForViewMessage == isFailureOrSuccessForViewMessage)&&(identical(other.isFailureOrSuccessForSendMessage, isFailureOrSuccessForSendMessage) || other.isFailureOrSuccessForSendMessage == isFailureOrSuccessForSendMessage)&&const DeepCollectionEquality().equals(other._chats, _chats)&&const DeepCollectionEquality().equals(other._displayedMessageIds, _displayedMessageIds)&&const DeepCollectionEquality().equals(other._displayedMessageKeys, _displayedMessageKeys)&&(identical(other.currentEmail, currentEmail) || other.currentEmail == currentEmail));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFailureOrSuccessForViewMessage,isFailureOrSuccessForSendMessage,const DeepCollectionEquality().hash(_chats),const DeepCollectionEquality().hash(_displayedMessageIds),const DeepCollectionEquality().hash(_displayedMessageKeys),currentEmail);

@override
String toString() {
  return 'MessageState(isLoading: $isLoading, isFailureOrSuccessForViewMessage: $isFailureOrSuccessForViewMessage, isFailureOrSuccessForSendMessage: $isFailureOrSuccessForSendMessage, chats: $chats, displayedMessageIds: $displayedMessageIds, displayedMessageKeys: $displayedMessageKeys, currentEmail: $currentEmail)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $MessageStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Option<Either<MainFailure, List<ChatsView>>> isFailureOrSuccessForViewMessage, Option<Either<MainFailure, Unit>> isFailureOrSuccessForSendMessage, List<ChatsView>? chats, Set<int> displayedMessageIds, Set<String> displayedMessageKeys, String? currentEmail
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of MessageState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFailureOrSuccessForViewMessage = null,Object? isFailureOrSuccessForSendMessage = null,Object? chats = freezed,Object? displayedMessageIds = null,Object? displayedMessageKeys = null,Object? currentEmail = freezed,}) {
  return _then(_Initial(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFailureOrSuccessForViewMessage: null == isFailureOrSuccessForViewMessage ? _self.isFailureOrSuccessForViewMessage : isFailureOrSuccessForViewMessage // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, List<ChatsView>>>,isFailureOrSuccessForSendMessage: null == isFailureOrSuccessForSendMessage ? _self.isFailureOrSuccessForSendMessage : isFailureOrSuccessForSendMessage // ignore: cast_nullable_to_non_nullable
as Option<Either<MainFailure, Unit>>,chats: freezed == chats ? _self._chats : chats // ignore: cast_nullable_to_non_nullable
as List<ChatsView>?,displayedMessageIds: null == displayedMessageIds ? _self._displayedMessageIds : displayedMessageIds // ignore: cast_nullable_to_non_nullable
as Set<int>,displayedMessageKeys: null == displayedMessageKeys ? _self._displayedMessageKeys : displayedMessageKeys // ignore: cast_nullable_to_non_nullable
as Set<String>,currentEmail: freezed == currentEmail ? _self.currentEmail : currentEmail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
