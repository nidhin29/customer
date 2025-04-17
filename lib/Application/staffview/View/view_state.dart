part of 'view_cubit.dart';

@freezed
abstract class ViewState with _$ViewState {
  const factory ViewState({
    required bool isLoading,
    required Option<Either<MainFailure, StaffModel>> isFailureorSuccess,
    required Option<Either<MainFailure, DetailModel>>
    isFailureorSuccessForDetail,
    required Option<Either<MainFailure, TeamModel>> isFailureorSuccessForTeam,
  }) = _Initial;

  factory ViewState.initial() => ViewState(
    isLoading: false,
    isFailureorSuccess: none(),
    isFailureorSuccessForDetail: none(),
    isFailureorSuccessForTeam: none(),
  );
}
