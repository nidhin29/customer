class Feedback {
  int? feedbackId;
  String? customerEmail;
  int? bookingId;
  String? feedback;
  String? datetime;

  Feedback({
    this.feedbackId,
    this.customerEmail,
    this.bookingId,
    this.feedback,
    this.datetime,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    feedbackId: json['feedback_id'] as int?,
    customerEmail: json['customer_email'] as String?,
    bookingId: json['booking_id'] as int?,
    feedback: json['feedback'] as String?,
    datetime: json['datetime'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'feedback_id': feedbackId,
    'customer_email': customerEmail,
    'booking_id': bookingId,
    'feedback': feedback,
    'datetime': datetime,
  };
}
