import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Profile/model/model.dart';
import 'package:customer/Domain/Profile/profile_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService profileService;
  ProfileCubit(this.profileService) : super(ProfileState.initial());

  getProfile() async {
    emit(
      state.copyWith(
        isLoading: true,
        isFailureOrSuccessForGet: none(),
        profileModel: null,
      ),
    );
    final response = await profileService.getProfile();
    response.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForGet: some(left(failure)),
          ),
        );
      },
      (profileModel) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccessForGet: some(right(profileModel)),
            profileModel: profileModel,
          ),
        );
      },
    );
  }
}
