part of 'message_cubit.dart';

@freezed
abstract class MessageState with _$MessageState {
  const factory MessageState({
    required bool isLoading,
    required Option<Either<MainFailure, List<ChatsView>>>
    isFailureOrSuccessForViewMessage,
    required Option<Either<MainFailure, Unit>> isFailureOrSuccessForSendMessage,
    required List<ChatsView>? chats,
    required Set<int> displayedMessageIds,
    required Set<String> displayedMessageKeys,
    required String? currentEmail,
  }) = _Initial;

  factory MessageState.initial() => MessageState(
    isLoading: false,
    chats: [],
    isFailureOrSuccessForViewMessage: none(),
    isFailureOrSuccessForSendMessage: none(),
    displayedMessageIds: {},
    displayedMessageKeys: {},
    currentEmail: null,
  );
}
