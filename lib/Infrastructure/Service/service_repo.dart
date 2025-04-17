import 'dart:developer';
import 'dart:io';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Service/_service.dart';
import 'package:customer/Domain/Service/service_model/service_model.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SService)
class ServiceRepo implements SService {
  @override
  Future<Either<MainFailure, Unit>> addService(Service service) async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      if (email == null) {
        return const Left(MainFailure.authFailure());
      }

      final Map<String, dynamic> headers = {
        'Content-Type': 'multipart/form-data',
      };

      final formData = FormData.fromMap({
        'rate': service.rate,
        'items': service.items,
        'description': service.description,
        'datetime': service.dateTime.toIso8601String(),
        'email_id_owner': email,
        'status': '1',
        'image': await MultipartFile.fromFile(
          service.image.path,
          filename: service.image.path.split('/').last,
        ),
      });

      final Response response = await Dio(
        BaseOptions(headers: headers),
      ).post("${baseUrl}User/add-service/", data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Service Added: ${response.data}");
        return Right(unit);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log("Error: $e");
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
  Future<Either<MainFailure, ServiceModel>> getService() async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(
        BaseOptions(headers: headers),
      ).get("${baseUrl}Customer/view-all-services/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final serviceModel = ServiceModel.fromJson(response.data);
        return Right(serviceModel);
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
  Future<Either<MainFailure, Unit>> bookService(
    String id,
    DateTime datetime,
  ) async {
    try {
      final sha = await SharedPreferences.getInstance();
      final email = sha.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "${baseUrl}Customer/book-service/",
        data: {
          'service_id': int.parse(id),
          'email_id_customer': email,
          'datetime': datetime.toIso8601String(),
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
}
