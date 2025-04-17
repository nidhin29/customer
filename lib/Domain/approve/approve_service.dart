import 'package:customer/Domain/Failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ApproveService {
  Future<Either<MainFailure, Unit>> approve({
    required String id,
    required String team,
  });

  Future<Either<MainFailure, Unit>> reject({
    required String id,
    required String team,
  });

  Future<Either<MainFailure, Unit>> markComplete({required String id});
}
