class Booking {
  int? id;
  String? items;
  String? service;
  double? rate;
  String? description;
  String? datetime;
  int? approvalStatus;
  int? paymentStatus;
  int? workCompletedStatus;
  String? assignedTeam;
  String? customerEmail;
  String? customerName;
  String? ownerName;
  String? ownerCompany;

  Booking({
    this.id,
    this.items,
    this.service,
    this.rate,
    this.description,
    this.datetime,
    this.approvalStatus,
    this.customerName,
    this.paymentStatus,
    this.workCompletedStatus,
    this.assignedTeam,
    this.customerEmail,
    this.ownerName,
    this.ownerCompany,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json['id'] as int?,
    items: json['items'] as String?,
    service: json['service'] as String?,
    rate: (json['rate'] as num?)?.toDouble(),
    description: json['description'] as String?,
    datetime: json['datetime'] as String?,
    approvalStatus: json['approvalStatus'] as int?,
    paymentStatus: json['paymentStatus'] as int?,
    workCompletedStatus: json['workCompletedStatus'] as int?,
    assignedTeam: json['assignedTeam'] as String?,
    customerEmail: json['customerEmail'] as String?,
    customerName: json['customer'] as String?,
    ownerName: json['ownerName'] as String?,
    ownerCompany: json['ownercompany'] as String?,
  );
}
