import 'detail.dart';

class EarnModel {
  String? status;
  String? staffName;
  String? team;
  double? wagePerWork;
  int? totalCompletedWorks;
  double? totalEarnings;
  List<Detail>? details;

  EarnModel({
    this.status,
    this.staffName,
    this.team,
    this.wagePerWork,
    this.totalCompletedWorks,
    this.totalEarnings,
    this.details,
  });

  factory EarnModel.fromJson(Map<String, dynamic> json) => EarnModel(
    status: json['status'] as String?,
    staffName: json['staff_name'] as String?,
    team: json['team'] as String?,
    wagePerWork: (json['wage_per_work'] as num?)?.toDouble(),
    totalCompletedWorks: json['total_completed_works'] as int?,
    totalEarnings: json['total_earnings'] as double?,
    details:
        (json['details'] as List<dynamic>?)
            ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'staff_name': staffName,
    'team': team,
    'wage_per_work': wagePerWork,
    'total_completed_works': totalCompletedWorks,
    'total_earnings': totalEarnings,
    'details': details?.map((e) => e.toJson()).toList(),
  };
}
