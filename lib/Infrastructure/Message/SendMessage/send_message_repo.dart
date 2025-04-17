import 'dart:developer';
import 'dart:io';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Message/SendMessage/send_message_service.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SendMessageService)
class SendMessageRepo implements SendMessageService {
  @override
  Future<Either<MainFailure, Unit>> sendMessage(
    int id,
    String message,
    String? email,
  ) async {
    try {
      final user = TokenManager.instance.user;
      final sharedPref = await SharedPreferences.getInstance();
      final email1 = sharedPref.getString('email');
      final staffType = TokenManager.instance.stafftype;
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "$baseUrl${user == '2' ? 'User2/send_chat_message/' : 'User/send_chat/'}",
        data:
            user == '2'
                ? {
                  "bookingid": id,
                  "staff_email": staffType == '1' ? email : email1,
                  "message": message,
                  "sts": staffType == '1' ? 1 : 2,
                  "staff_type": int.parse(staffType!),
                }
                : {"booking_id": id, "message": message},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
