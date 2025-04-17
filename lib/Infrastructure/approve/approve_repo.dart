import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/approve/approve_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ApproveService)
class ApproveRepo implements ApproveService {
  @override
  Future<Either<MainFailure, Unit>> approve({
    required String id,
    required String team,
  }) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User/approve-booking/",
        data: {'booking_id': int.parse(id), 'team': team},
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
  Future<Either<MainFailure, Unit>> reject({
    required String id,
    required String team,
  }) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User/reject_booking/",
        data: {'booking_id': int.parse(id), 'team': team},
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
  Future<Either<MainFailure, Unit>> markComplete({required String id}) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User2/mark-work-done/",
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
