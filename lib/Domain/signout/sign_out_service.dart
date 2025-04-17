import 'package:customer/Domain/Failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SignOutService {
  Future<Either<MainFailure, Unit>> signOut(String deviceid);
}
