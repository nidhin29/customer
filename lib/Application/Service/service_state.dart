part of 'service_cubit.dart';

@freezed
abstract class ServiceState with _$ServiceState {
  const factory ServiceState({
    required bool isLoading,
    required Option<Either<MainFailure, Unit>> isFailureOrSuccess,
    required Option<Either<MainFailure, ServiceModel>> isFailureOrSuccessforGet,
  }) = _Initial;

  factory ServiceState.initial() => ServiceState(
    isLoading: false,
    isFailureOrSuccess: none(),
    isFailureOrSuccessforGet: none(),
  );
}
