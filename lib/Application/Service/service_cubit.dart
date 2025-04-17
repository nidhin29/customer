import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Service/_service.dart';
import 'package:customer/Domain/Service/service_model/service_model.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'service_state.dart';
part 'service_cubit.freezed.dart';

@injectable
class ServiceCubit extends Cubit<ServiceState> {
  final SService _feedbackService;
  ServiceCubit(this._feedbackService) : super(ServiceState.initial());

  submitFeedback(Service service) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final response = await _feedbackService.addService(service);
    response.fold(
      (l) => emit(
        state.copyWith(isLoading: false, isFailureOrSuccess: some(left(l))),
      ),
      (r) => emit(
        state.copyWith(isLoading: false, isFailureOrSuccess: some(right(r))),
      ),
    );
  }

  getService() async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccessforGet: none()));
    final response = await _feedbackService.getService();
    response.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          isFailureOrSuccessforGet: some(left(l)),
        ),
      ),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          isFailureOrSuccessforGet: some(right(r)),
        ),
      ),
    );
  }

  bookService(String id, DateTime dateTime) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final response = await _feedbackService.bookService(id, dateTime);
    response.fold(
      (l) => emit(
        state.copyWith(isLoading: false, isFailureOrSuccess: some(left(l))),
      ),
      (r) => emit(
        state.copyWith(isLoading: false, isFailureOrSuccess: some(right(r))),
      ),
    );
  }
}
