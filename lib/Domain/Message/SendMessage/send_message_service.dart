import 'package:customer/Domain/Failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SendMessageService {
  Future<Either<MainFailure, Unit>> sendMessage(
    int id,
    String message,
    String? email,
  );
}
