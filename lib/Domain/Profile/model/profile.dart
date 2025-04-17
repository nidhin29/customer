class Profile {
  String? name;
  String? address;
  String? mobNo;
  String? idProof;
  int? status;

  Profile({this.name, this.address, this.mobNo, this.idProof, this.status});

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    name: json['name'] as String?,
    address: json['address'] as String?,
    mobNo: json['mob_no'] as String?,
    idProof: json['id_proof'] as String?,
    status: json['status'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'mob_no': mobNo,
    'id_proof': idProof,
    'status': status,
  };
}
