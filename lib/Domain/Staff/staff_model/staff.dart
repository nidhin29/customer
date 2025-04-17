class Staff {
  String? staffId;
  String? staffName;
  String? staffType;

  Staff({this.staffId, this.staffName, this.staffType});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    staffId: json['staff_id'] as String?,
    staffName: json['staff_name'] as String?,
    staffType: json['staff_type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'staff_name': staffName,
    'staff_type': staffType,
  };
}
