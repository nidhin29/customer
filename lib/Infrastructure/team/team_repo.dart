import 'dart:developer';
import 'dart:io';
import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Team/team_model/team_model.dart';
import 'package:customer/Domain/Team/team_service.dart';
import 'package:customer/constants/const.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TeamService)
class TeamRepo implements TeamService {
  @override
  Future<Either<MainFailure, TeamModel>> getTeam(int bookingId) async {
    try {
      final Map<String, dynamic> headers = {'Content-Type': 'application/json'};
      final Response response = await Dio(
        BaseOptions(headers: headers),
      ).post("${baseUrl}User2/my_team_mates/", data: {"booking_id": bookingId});
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final teamModel = TeamModel.fromJson(response.data);
        return Right(teamModel);
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
