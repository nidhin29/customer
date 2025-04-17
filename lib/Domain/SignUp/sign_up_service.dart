import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpService {
  Future<Either<MainFailure, Unit>> signUpCustomer(CustomerSignUpData data);
  Future<Either<MainFailure, Unit>> signUpOwner(OwnerSignUpData data);
}

class CustomerSignUpData {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;
  final String idProof;

  CustomerSignUpData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.idProof,
  });
}

class OwnerSignUpData {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String password;
  final String companyName;
  final File licenseDocument;

  OwnerSignUpData({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
    required this.companyName,
    required this.licenseDocument,
  });
}
