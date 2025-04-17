import 'staff_details.dart';

class DetailModel {
  String? status;
  StaffDetails? staffDetails;

  DetailModel({this.status, this.staffDetails});

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
    status: json['status'] as String?,
    staffDetails:
        json['staff_details'] == null
            ? null
            : StaffDetails.fromJson(
              json['staff_details'] as Map<String, dynamic>,
            ),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'staff_details': staffDetails?.toJson(),
  };
}
