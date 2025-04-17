import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/feedback/feedback_model/feedback_model.dart';
import 'package:dartz/dartz.dart';

abstract class FeedbackService {
  Future<Either<MainFailure, FeedbackModel>> getFeedback();
  Future<Either<MainFailure, Unit>> addFeedback({
    required String id,
    required String feedback,
  });
  Future<Either<MainFailure, Unit>> makePayment({required String id});
}
