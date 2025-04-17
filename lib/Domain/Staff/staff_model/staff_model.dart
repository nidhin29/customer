import 'staff.dart';

class StaffModel {
  String? status;
  List<Staff>? staffs;

  StaffModel({this.status, this.staffs});

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    status: json['status'] as String?,
    staffs:
        (json['staffs'] as List<dynamic>?)
            ?.map((e) => Staff.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'staffs': staffs?.map((e) => e.toJson()).toList(),
  };
}
