import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/earn/earn_model/earn_model.dart';
import 'package:customer/Domain/earn/earn_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: EarnService)
class EarnRepo implements EarnService {
  @override
  Future<Either<MainFailure, EarnModel>> earn() async {
     try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}User2/my_earnings/",
        data: {
          'email_id_staff': email,

        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final earnModel = EarnModel.fromJson(response.data);
        return Right(earnModel);
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
