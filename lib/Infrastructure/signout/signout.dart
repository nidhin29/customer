import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/signout/sign_out_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SignOutService)
class SignoutRepo implements SignOutService {
  @override
  Future<Either<MainFailure, Unit>> signOut(String deviceid) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Response response = await Dio(
        BaseOptions(headers: headers),
      ).post("${baseUrl}api/UserLogout", data: {'email': email});
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
      } else if (e is DioException && e.response?.statusCode == 409) {
        return const Left(MainFailure.authFailure());
      } else {
        return const Left(MainFailure.otherFailure());
      }
    }
  }
}
