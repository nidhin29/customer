import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Staff/detail_model/detail_model.dart';
import 'package:customer/Domain/Staff/staff_model/staff_model.dart';
import 'package:dartz/dartz.dart';

abstract class StaffService {
  Future<Either<MainFailure, Unit>> addStaff(Staff staff);
  Future<Either<MainFailure, StaffModel>> viewStaff(String team);
  Future<Either<MainFailure, DetailModel>> detailStaff(String id);
}

class Staff {
  String name;
  String address;
  String mobNo;
  String idProof;
  String emailIdStaff;
  String password;
  String upi;
  double wage;
  String assignedTo;
  String staffType;

  Staff({
    required this.name,
    required this.address,
    required this.mobNo,
    required this.idProof,
    required this.emailIdStaff,
    required this.password,
    required this.upi,
    required this.wage,
    required this.assignedTo,
    required this.staffType,
  });
}
