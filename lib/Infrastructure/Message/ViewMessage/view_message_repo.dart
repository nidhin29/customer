import 'dart:developer';
import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Message/ViewMessage/view_message_model.dart';
import 'package:customer/Domain/Message/ViewMessage/view_message_service.dart';
import 'package:customer/Domain/TokenManager/token_manager.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ViewMessageService)
class ViewMessageServiceRepo implements ViewMessageService {
  @override
  Future<Either<MainFailure, ViewMessageModel>> getViewMessages(
    int id,
    String? email,
  ) async {
    try {
      final user = TokenManager.instance.user;
      final staffType = TokenManager.instance.stafftype;
      final sharedPref = await SharedPreferences.getInstance();
      final email1 = sharedPref.getString('email');
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(BaseOptions(headers: headers)).post(
        "$baseUrl${user == '2' ? 'User2/fetch_chat_messages/' : 'User/view_chat/'}",
        data:
            user == '2'
                ? {"bookingid": id, "staff_email":staffType == '1' ? email : email1}
                : {"booking_id": id},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final viewMessageModel = ViewMessageModel.fromJson(
          response.data,
          userType: int.parse(user!),
        );
        return Right(viewMessageModel);
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
