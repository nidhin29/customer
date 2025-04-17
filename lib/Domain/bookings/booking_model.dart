import 'booking.dart';

class BookingModel {
  List<Booking>? bookings;
  String? status;
  String? team;

  BookingModel({this.bookings, this.status, this.team});

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    bookings:
        (json['bookings'] as List<dynamic>?)
            ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
            .toList(),
    status: json['status'] as String?,
    team: json['team'] as String?,
  );
}
