import 'service.dart';

class ServiceModel {
  String? status;
  List<Service>? services;

  ServiceModel({this.status, this.services});

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
    status: json['status'] as String?,
    services:
        (json['services'] as List<dynamic>?)
            ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'services': services?.map((e) => e.toJson()).toList(),
  };
}
