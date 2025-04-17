class Detail {
  int? bookingId;
  String? item;
  double? rate;
  String? date;

  Detail({this.bookingId, this.item, this.rate, this.date});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    bookingId: json['booking_id'] as int?,
    item: json['item'] as String?,
    rate: (json['rate'] as num?)?.toDouble(),
    date: json['date'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'item': item,
    'rate': rate,
    'date': date,
  };
}
