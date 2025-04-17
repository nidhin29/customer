import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/SignIn/sign_in_model.dart';
import 'package:dartz/dartz.dart';

abstract class SignInService {
  Future<Either<MainFailure, SignInModel>> signInWithEmailAndPassword(
    String email,
    String password,
    int status,
  );
}
