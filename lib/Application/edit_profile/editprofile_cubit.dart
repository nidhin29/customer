import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Profile/profile_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'editprofile_state.dart';
part 'editprofile_cubit.freezed.dart';

@injectable
class EditprofileCubit extends Cubit<EditprofileState> {
  final ProfileService profileService;
  EditprofileCubit(this.profileService) : super(EditprofileState.initial());

  updateProfile({required ProfileModel profileModel}) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccessForUpdate: none()));
    final response = await profileService.updateProfile(
      profileModel: profileModel,
    );
    response.fold(
      (f) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForUpdate: some(left(f)),
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForUpdate: some(right(r)),
          ),
        );
      },
    );
  }
}
