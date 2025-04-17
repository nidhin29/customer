import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Staff/staff_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'staff_state.dart';
part 'staff_cubit.freezed.dart';

@injectable
class StaffCubit extends Cubit<StaffState> {
  final StaffService _feedbackService;
  StaffCubit(this._feedbackService) : super(StaffState.initial());

  submitFeedback(Staff staff) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final response = await _feedbackService.addStaff(staff);
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
