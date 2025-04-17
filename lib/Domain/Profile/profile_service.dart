import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Profile/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileService {
  Future<Either<MainFailure, Model>> getProfile();
  Future<Either<MainFailure, Unit>> updateProfile({
    required ProfileModel profileModel,
  });
}

class ProfileModel {
  final String name;
  final String address;
  final String mobileNumber;
  final String idProof;

  ProfileModel({
    required this.name,
    required this.address,
    required this.mobileNumber,
    required this.idProof,
  });
}
