import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/bookings/booking_model.dart';
import 'package:customer/Domain/bookings/booking_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: BookingService)
class BookingRepo implements BookingService {
  @override
  Future<Either<MainFailure, BookingModel>> getBookings() async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final type = sha.getString('user');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final dio = Dio(BaseOptions(headers: headers));
      final Response response;
      if (type == '1') {
        response = await dio.get(
          "${baseUrl}User/view-bookings/",
          queryParameters: {'owner_email': email},
        );
      } else if (type == '3') {
        response = await dio.post(
          "${baseUrl}Customer/view-my-bookings/",
          data: {'email_id_customer': email},
        );
      } else {
        response = await dio.post(
          "${baseUrl}User2/staff-team-bookings/",
          data: {'email_id_staff': email},
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final appointmnets = BookingModel.fromJson(response.data);
        return Right(appointmnets);
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
