class Staff {
  String? name;
  String? email;
  String? mobNo;
  String? staffType;

  Staff({this.name, this.email, this.mobNo, this.staffType});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    name: json['name'] as String?,
    email: json['email'] as String?,
    mobNo: json['mob_no'] as String?,
    staffType: json['staff_type'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'mob_no': mobNo,
    'staff_type': staffType,
  };
}
