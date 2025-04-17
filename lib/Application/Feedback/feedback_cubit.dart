import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/earn/earn_model/earn_model.dart';
import 'package:customer/Domain/earn/earn_service.dart';
import 'package:customer/Domain/feedback/feedback_model/feedback_model.dart';
import 'package:customer/Domain/feedback/feedback_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feedback_state.dart';
part 'feedback_cubit.freezed.dart';

@injectable
class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackService _feedbackService;
  final EarnService _earnService;
  FeedbackCubit(this._feedbackService, this._earnService) : super(FeedbackState.initial());

  getFeedback() async {
    emit(state.copyWith(isLoading: true));
    final result = await _feedbackService.getFeedback();
    result.fold(
      (f) {
        emit(
          state.copyWith(isLoading: false, isFailureOrSuccess: some(left(f))),
        );
      },
      (r) {
        emit(
          state.copyWith(isLoading: false, isFailureOrSuccess: some(right(r))),
        );
      },
    );
  }

  addFeedback(String id, String feedback) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccessforAdd: none()));
    final result = await _feedbackService.addFeedback(
      id: id,
      feedback: feedback,
    );
    result.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforAdd: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforAdd: some(right(r)),
          ),
        );
      },
    );
  }

  makePayment(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _feedbackService.makePayment(id: id);
    result.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforAdd: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforAdd: some(right(r)),
          ),
        );
      },
    );
  }

  earn() async{
     emit(state.copyWith(isLoading: true));
    final result = await _earnService.earn();
    result.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforEarn: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessforEarn: some(right(r)),
          ),
        );
      },
    );
  }
}
