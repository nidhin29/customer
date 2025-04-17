import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Message/ViewMessage/view_message_model.dart';
import 'package:dartz/dartz.dart';

abstract class ViewMessageService {
  Future<Either<MainFailure, ViewMessageModel>> getViewMessages(
    int id,
    String? email,
  );
}
