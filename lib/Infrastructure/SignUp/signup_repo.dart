import 'dart:developer';
import 'dart:io';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/SignUp/sign_up_service.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SignUpService)
class SignUpRepo implements SignUpService {
  @override
  Future<Either<MainFailure, Unit>> signUpCustomer(
    CustomerSignUpData data,
  ) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};

      final response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}register-customer/",
        data: {
          "name": data.name,
          "email_id_customer": data.email,
          "mob_no": data.phoneNumber,
          "address": data.address,
          "password": data.password,
          "id_proof": data.idProof,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        TokenManager.instance.setEmail(data.email);
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setString('email', data.email);
        await sharedPref.setString('user', '3');
        TokenManager.instance.setUser('3');
        log(response.data.toString());
        return const Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return _handleException(e);
    }
  }

  @override
  Future<Either<MainFailure, Unit>> signUpOwner(OwnerSignUpData data) async {
    try {
      final dio = Dio();
      final formData = FormData.fromMap({
        "name": data.name,
        "email_id_owner": data.email,
        "mob_no": data.phoneNumber,
        "address": data.address,
        "password": data.password,
        "company_name": data.companyName,
        "license_document": await MultipartFile.fromFile(
          data.licenseDocument.path,
          filename: data.licenseDocument.path.split('/').last,
        ),
      });

      final response = await dio.post(
        "${baseUrl}register-owner/",
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        TokenManager.instance.setEmail(data.email);
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setString('email', data.email);
        await sharedPref.setString('user', '1');
        TokenManager.instance.setUser('1');
        log(response.data.toString());
        return const Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return _handleException(e);
    }
  }

  Either<MainFailure, Unit> _handleException(dynamic e) {
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
