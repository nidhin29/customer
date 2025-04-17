import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Team/team_model/team_model.dart';
import 'package:dartz/dartz.dart';

abstract class TeamService {
  Future<Either<MainFailure, TeamModel>> getTeam(int bookingId);
}
