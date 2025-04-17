part of 'feedback_cubit.dart';

@freezed
abstract class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    required bool isLoading,
    required Option<Either<MainFailure, FeedbackModel>> isFailureOrSuccess,
    required Option<Either<MainFailure, Unit>> isFailureOrSuccessforAdd,
    required Option<Either<MainFailure,EarnModel>> isFailureOrSuccessforEarn,
  }) = _Initial;

  factory FeedbackState.initial() => FeedbackState(
    isLoading: false,
    isFailureOrSuccess: none(),
    isFailureOrSuccessforAdd: none(),
    isFailureOrSuccessforEarn: none(),
  );
}
