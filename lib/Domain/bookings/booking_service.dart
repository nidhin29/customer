import 'package:customer/Domain/Failure/failure.dart';
import 'package:customer/Domain/bookings/booking_model.dart';
import 'package:dartz/dartz.dart';

abstract class BookingService {
  Future<Either<MainFailure, BookingModel>> getBookings();
}
