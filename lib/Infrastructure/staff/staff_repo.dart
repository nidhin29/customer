import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Staff/detail_model/detail_model.dart';
import 'package:customer/Domain/Staff/staff_model/staff_model.dart';
import 'package:customer/Domain/Staff/staff_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: StaffService)
class FeedbackRepo implements StaffService {
  @override
  Future<Either<MainFailure, Unit>> addStaff(Staff staff) async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};

      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User/register-staff/",
        data: {
          "name": staff.name,
          "address": staff.address,
          "mob_no": staff.mobNo,
          "id_proof": staff.idProof,
          "email_id_staff": staff.emailIdStaff,
          "email_id_owner": email,
          "password": staff.password,
          "upi": staff.upi,
          "wage": staff.wage,
          "assigned_to": staff.assignedTo,
          "staff_type": staff.staffType,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      return _handleException(e);
    }
  }

  T _handleException<T>(dynamic e) {
    log(e.toString());
    if (e is DioException && e.response?.statusCode == 500) {
      return const Left(MainFailure.serverFailure()) as T;
    } else if (e is SocketException) {
      return const Left(MainFailure.clientFailure()) as T;
    } else if (e is DioException && e.response?.statusCode == 404) {
      return const Left(MainFailure.authFailure()) as T;
    } else if (e is DioException && e.response?.statusCode == 400) {
      return const Left(MainFailure.incorrectCredential()) as T;
    } else {
      return const Left(MainFailure.otherFailure()) as T;
    }
  }

  @override
  Future<Either<MainFailure, StaffModel>> viewStaff(String team) async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};

      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User/view_staff_by_team/",
        data: {"owner_email": email, "team": team},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final staffModel = StaffModel.fromJson(response.data);
        return Right(staffModel);
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
  Future<Either<MainFailure, DetailModel>> detailStaff(String id) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(
        BaseOptions(headers: headers),
      ).post("${baseUrl}User/view_staff_detail/", data: {"staff_id": id});

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final detailModel = DetailModel.fromJson(response.data);
        return Right(detailModel);
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
