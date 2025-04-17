class StaffDetails {
  String? name;
  String? emailIdStaff;
  String? address;
  String? mobNo;
  String? idProof;
  String? upi;
  double? wage;
  String? assignedTo;
  String? staffType;
  int? status;
  String? emailIdOwner;
  dynamic emailIdShop;

  StaffDetails({
    this.name,
    this.emailIdStaff,
    this.address,
    this.mobNo,
    this.idProof,
    this.upi,
    this.wage,
    this.assignedTo,
    this.staffType,
    this.status,
    this.emailIdOwner,
    this.emailIdShop,
  });

  factory StaffDetails.fromJson(Map<String, dynamic> json) => StaffDetails(
    name: json['name'] as String?,
    emailIdStaff: json['email_id_staff'] as String?,
    address: json['address'] as String?,
    mobNo: json['mob_no'] as String?,
    idProof: json['id_proof'] as String?,
    upi: json['upi'] as String?,
    wage: (json['wage'] as num?)?.toDouble(),
    assignedTo: json['assigned_to'] as String?,
    staffType: json['staff_type'] as String?,
    status: json['status'] as int?,
    emailIdOwner: json['email_id_owner'] as String?,
    emailIdShop: json['email_id_shop'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email_id_staff': emailIdStaff,
    'address': address,
    'mob_no': mobNo,
    'id_proof': idProof,
    'upi': upi,
    'wage': wage,
    'assigned_to': assignedTo,
    'staff_type': staffType,
    'status': status,
    'email_id_owner': emailIdOwner,
    'email_id_shop': emailIdShop,
  };
}
