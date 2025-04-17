class ViewMessageModel {
  List<ChatsView>? chats;

  ViewMessageModel({this.chats});

  factory ViewMessageModel.fromJson(
    Map<String, dynamic> json, {
    required int userType,
  }) {
    if (userType == 2 && json['chat'] != null) {
      return ViewMessageModel(
        chats:
            (json['chat'] as List)
                .map((e) => ChatsView.fromJson(e, userType: userType))
                .toList(),
      );
    } else if (json['chats'] != null) {
      return ViewMessageModel(
        chats:
            (json['chats'] as List)
                .map((e) => ChatsView.fromJson(e, userType: userType))
                .toList(),
      );
    }
    return ViewMessageModel();
  }

  Map<String, dynamic> toJson() {
    return {'chats': chats?.map((e) => e.toJson()).toList()};
  }
}

class ChatsView {
  int? id;
  String? message;
  int? direction; // For userType == 2, this will be 'sts'
  String? timestamp;
  String? staffType;
  String? staffEmail;

  ChatsView({
    this.id,
    this.message,
    this.direction,
    this.timestamp,
    this.staffType,
    this.staffEmail,
  });

  factory ChatsView.fromJson(
    Map<String, dynamic> json, {
    required int userType,
  }) {
    return ChatsView(
      id: json['id'],
      message: json['message'],
      direction: json['direction'] ?? json['sts'], // fallback
      timestamp: json['timestamp'],
      staffType: userType == 2 ? json['staff_type'] : null,
      staffEmail: userType == 2 ? json['staff_email'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'direction': direction,
      'timestamp': timestamp,
      'staff_type': staffType,
      'staff_email': staffEmail,
    };
  }
}
