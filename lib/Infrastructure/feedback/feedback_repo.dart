import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/feedback/feedback_model/feedback_model.dart';
import 'package:customer/Domain/feedback/feedback_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: FeedbackService)
class FeedbackRepo implements FeedbackService {
  @override
  Future<Either<MainFailure, FeedbackModel>> getFeedback() async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User/view_feedback_for_owner/",
        data: {'owner_email': email},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final feedbackModel = FeedbackModel.fromJson(response.data);
        return Right(feedbackModel);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      if (e is DioException && e.response?.statusCode == 500) {
        return const Left(MainFailure.serverFailure());
      } else if (e is SocketException) {
        return const Left(MainFailure.clientFailure());
      } else if (e is DioException && e.response?.statusCode == 404) {
        return const Left(MainFailure.authFailure());
      } else if (e is DioException && e.response?.statusCode == 400) {
        return const Left(MainFailure.incorrectCredential());
      } else {
        return const Left(MainFailure.otherFailure());
      }
    }
  }

  @override
  Future<Either<MainFailure, Unit>> addFeedback({
    required String id,
    required String feedback,
  }) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}Customer/give-feedback/",
        data: {
          'email_id_customer': email,
          'bookingid': int.parse(id),
          'feedback': feedback,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      if (e is DioException && e.response?.statusCode == 500) {
        return const Left(MainFailure.serverFailure());
      } else if (e is SocketException) {
        return const Left(MainFailure.clientFailure());
      } else if (e is DioException && e.response?.statusCode == 404) {
        return const Left(MainFailure.authFailure());
      } else if (e is DioException && e.response?.statusCode == 400) {
        return const Left(MainFailure.incorrectCredential());
      } else {
        return const Left(MainFailure.otherFailure());
      }
    }
  }

  @override
  Future<Either<MainFailure, Unit>> makePayment({required String id}) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}Customer/make-payment/",
        data: {'booking_id': int.parse(id)},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      if (e is DioException && e.response?.statusCode == 500) {
        return const Left(MainFailure.serverFailure());
      } else if (e is SocketException) {
        return const Left(MainFailure.clientFailure());
      } else if (e is DioException && e.response?.statusCode == 404) {
        return const Left(MainFailure.authFailure());
      } else if (e is DioException && e.response?.statusCode == 400) {
        return const Left(MainFailure.incorrectCredential());
      } else {
        return const Left(MainFailure.otherFailure());
      }
    }
  }
}
