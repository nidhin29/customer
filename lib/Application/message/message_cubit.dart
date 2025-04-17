import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Message/SendMessage/send_message_service.dart';
import 'package:customer/Domain/Message/ViewMessage/view_message_model.dart';
import 'package:customer/Domain/Message/ViewMessage/view_message_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'message_state.dart';
part 'message_cubit.freezed.dart';

@injectable
class MessageCubit extends Cubit<MessageState> {
  final ViewMessageService viewMessageService;
  final SendMessageService sendMessageService;

  MessageCubit(this.viewMessageService, this.sendMessageService)
    : super(MessageState.initial());

  Future<void> viewMessages(int id, int userType, String? email) async {
    if (state.currentEmail != email) {
      // Reset the state if the email is different
      emit(
        state.copyWith(
          chats: [],
          displayedMessageKeys: {},
          displayedMessageIds: {},
          currentEmail: email, // Update the current email
        ),
      );
    }
    emit(
      state.copyWith(isLoading: true, isFailureOrSuccessForViewMessage: none()),
    );
    final response = await viewMessageService.getViewMessages(id, email);
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForViewMessage: some(left(failure)),
          ),
        );
      },
      (chatModel) {
        if (userType == 2) {
          final newMessages =
              chatModel.chats!.where((message) {
                final key = "${message.message}|${message.timestamp}";
                return !state.displayedMessageKeys.contains(key);
              }).toList();
          final updatedMessageKeys = {
            ...state.displayedMessageKeys,
            ...newMessages.map((e) => "${e.message}|${e.timestamp}"),
          };
          final updatedMessages = [...?state.chats, ...newMessages];
          emit(
            state.copyWith(
              isLoading: false,
              chats: updatedMessages,
              displayedMessageKeys: updatedMessageKeys,
              isFailureOrSuccessForViewMessage: some(right(updatedMessages)),
            ),
          );
        } else {
          // Normal users: dedupe using id
          final newMessages =
              chatModel.chats!.where((message) {
                return message.id != null &&
                    !state.displayedMessageIds.contains(message.id);
              }).toList();

          final updatedMessageIds = {
            ...state.displayedMessageIds,
            ...newMessages.map((e) => e.id!).whereType<int>(),
          };

          final updatedMessages = [...?state.chats, ...newMessages];

          emit(
            state.copyWith(
              isLoading: false,
              chats: updatedMessages,
              displayedMessageIds: updatedMessageIds,
              isFailureOrSuccessForViewMessage: some(right(updatedMessages)),
            ),
          );
        }
      },
    );
  }

  Future<void> sendMessage(int id, String message, String? email) async {
    emit(
      state.copyWith(isLoading: true, isFailureOrSuccessForSendMessage: none()),
    );

    final response = await sendMessageService.sendMessage(id, message, email);
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForSendMessage: some(left(failure)),
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForSendMessage: some(right(unit)),
          ),
        );
      },
    );
  }
}
