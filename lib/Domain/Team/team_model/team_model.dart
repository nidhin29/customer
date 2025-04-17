import 'staff.dart';

class TeamModel {
  String? status;
  String? team;
  List<Staff>? staff;

  TeamModel({this.status, this.team, this.staff});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    status: json['status'] as String?,
    team: json['team'] as String?,
    staff:
        (json['staff'] as List<dynamic>?)
            ?.map((e) => Staff.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'team': team,
    'staff': staff?.map((e) => e.toJson()).toList(),
  };
}
