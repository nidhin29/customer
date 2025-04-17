import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/earn/earn_model/earn_model.dart';
import 'package:dartz/dartz.dart';

abstract class EarnService {
  Future<Either<MainFailure,EarnModel>> earn();
}
