import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/SignIn/sign_in_model.dart';
import 'package:customer/Domain/SignIn/sign_in_service.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/Domain/TokenManager/token_service.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'signin_state.dart';
part 'signin_cubit.freezed.dart';

@injectable
class SigninCubit extends Cubit<SigninState> {
  final SignInService _signInService;
  final TokenService _tokenService;
  SigninCubit(this._signInService, this._tokenService)
    : super(SigninState.initial());

  signIn(String email, String password, int stats) async {
    emit(state.copyWith(isLoading: true, isFailureOrSuccess: none()));
    final response = await _signInService.signInWithEmailAndPassword(
      email,
      password,
      stats,
    );
    response.fold(
      (l) => emit(
        state.copyWith(isLoading: false, isFailureOrSuccess: some(left(l))),
      ),
      (r) async {
        log(r.email.toString());
        TokenManager.instance.setEmail(r.email!);
        if (stats == 2) {
          TokenManager.instance.setStaffType(r.stafftype!);
        }
        await _tokenService.saveEmail();
        emit(
          state.copyWith(isLoading: false, isFailureOrSuccess: some(right(r))),
        );
      },
    );
  }
}
