part of 'staff_cubit.dart';

@freezed
abstract class StaffState with _$StaffState {
  const factory StaffState({
    required bool isLoading,
    required Option<Either<MainFailure, Unit>> isFailureOrSuccess,
  }) = _Initial;

  factory StaffState.initial() =>
      StaffState(isLoading: false, isFailureOrSuccess: none());
}
