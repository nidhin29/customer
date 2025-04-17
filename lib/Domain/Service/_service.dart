import 'dart:io';

import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/Service/service_model/service_model.dart';
import 'package:dartz/dartz.dart';

abstract class SService {
  Future<Either<MainFailure, Unit>> addService(Service service);
  Future<Either<MainFailure, ServiceModel>> getService();
  Future<Either<MainFailure, Unit>> bookService(String id, DateTime dateTime);
}

class Service {
  String rate;
  String items;
  String description;
  File image;
  DateTime dateTime;

  Service({
    required this.rate,
    required this.items,
    required this.description,
    required this.image,
    required this.dateTime,
  });
}
