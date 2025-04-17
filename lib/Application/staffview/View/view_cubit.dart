import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Staff/detail_model/detail_model.dart';
import 'package:customer/Domain/Staff/staff_model/staff_model.dart';
import 'package:customer/Domain/Staff/staff_service.dart';
import 'package:customer/Domain/Team/team_model/team_model.dart';
import 'package:customer/Domain/Team/team_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'view_state.dart';
part 'view_cubit.freezed.dart';

@injectable
class ViewCubit extends Cubit<ViewState> {
  final StaffService _staffService;

  final TeamService _teamService;
  ViewCubit(this._staffService, this._teamService) : super(ViewState.initial());

  getStaffs(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _staffService.viewStaff(id);
    result.fold(
      (f) {
        emit(
          state.copyWith(isLoading: false, isFailureorSuccess: some(left(f))),
        );
      },
      (r) {
        emit(
          state.copyWith(isLoading: false, isFailureorSuccess: some(right(r))),
        );
      },
    );
  }

  getDetail(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _staffService.detailStaff(id);
    result.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureorSuccessForDetail: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureorSuccessForDetail: some(right(r)),
          ),
        );
      },
    );
  }

  getTeam(int id) async {
    emit(state.copyWith(isLoading: true));
    final result = await _teamService.getTeam(id);
    result.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureorSuccessForTeam: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureorSuccessForTeam: some(right(r)),
          ),
        );
      },
    );
  }
}
