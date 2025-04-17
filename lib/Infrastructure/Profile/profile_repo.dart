import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Profile/model/model.dart';
import 'package:customer/Domain/Profile/profile_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ProfileService)
class ProfileRepo implements ProfileService {
  @override
  Future<Either<MainFailure, Model>> getProfile() async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}Customer/view-customer-profile/",
        data: {'email': email},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final profileModel = Model.fromJson(response.data);
        return Right(profileModel);
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
  Future<Either<MainFailure, Unit>> updateProfile({
    required ProfileModel profileModel,
  }) async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}Customer/update-customer-profile/",
        data: {
          'email': email,
          'name': profileModel.name,
          'address': profileModel.address,
          'mob_no': profileModel.mobileNumber,
          'id_proof': profileModel.idProof,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        return const Right(unit);
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
