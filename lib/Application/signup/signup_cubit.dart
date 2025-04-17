import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/SignUp/sign_up_service.dart';
// import 'package:customer/Domain/TokenManager/token_manager.dart';
// import 'package:customer/Domain/TokenManager/token_service.dart';
import 'package:customer/Presentation/Auth/signin.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignUpService _signUpService;

  SignupCubit(this._signUpService) : super(SignupState.initial());

  Future<void> signUp({
    required UserType userType,
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
    String? idProof, // customer only
    String? companyName, // owner only
    File? licenseDocument, // owner only
  }) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));

    Either<MainFailure, Unit> response;

    if (userType == UserType.customer) {
      final customerData = CustomerSignUpData(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        password: password,
        idProof: idProof ?? '',
      );

      response = await _signUpService.signUpCustomer(customerData);
    } else {
      final ownerData = OwnerSignUpData(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        password: password,
        companyName: companyName ?? '',
        licenseDocument: licenseDocument!,
      );

      response = await _signUpService.signUpOwner(ownerData);
    }

    response.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isFailureOrSuccess: some(left(failure)),
        ),
      ),
      (success) async {
        emit(
          state.copyWith(
            isLoading: false,
            isFailureOrSuccess: some(right(unit)),
          ),
        );
      },
    );
  }
}
