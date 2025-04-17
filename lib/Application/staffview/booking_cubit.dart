import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/approve/approve_service.dart';
import 'package:customer/Domain/bookings/booking_model.dart';
import 'package:customer/Domain/bookings/booking_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'booking_state.dart';
part 'booking_cubit.freezed.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final BookingService _bookingService;
  final ApproveService _approveService;
  BookingCubit(this._bookingService, this._approveService)
    : super(BookingState.initial());

  getBookings() async {
    emit(state.copyWith(isLoading: true));
    final result = await _bookingService.getBookings();
    result.fold(
      (f) {
        emit(state.copyWith(isLoading: false, bookings: some(left(f))));
      },
      (r) {
        emit(state.copyWith(isLoading: false, bookings: some(right(r))));
      },
    );
  }

  approveBooking(String id, String team) async {
    emit(state.copyWith(isLoading: true));
    final result = await _approveService.approve(id: id, team: team);
    result.fold(
      (f) {
        emit(state.copyWith(isLoading: false));
      },
      (r) {
        getBookings();
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  rejectBooking(String id, String team) async {
    emit(state.copyWith(isLoading: true));
    final result = await _approveService.approve(id: id, team: team);
    result.fold(
      (f) {
        emit(state.copyWith(isLoading: false));
      },
      (r) {
        getBookings();
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  markComplete(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _approveService.markComplete(id: id);
    result.fold(
      (f) {
        emit(state.copyWith(isLoading: false));
      },
      (r) {
        getBookings();
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
