class SignInModel {
  String? message;
  String? email;
  String? name;
  int? userType; // Added userType field
  String? stafftype;

  SignInModel({
    this.message,
    this.email,
    this.name,
    this.userType,
    this.stafftype,
  });

  SignInModel.fromJson(Map<String, dynamic> json) {
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }

    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["user_type"] is int) {
      userType = json["user_type"];
    }
    if (json["staff_type"] is String) {
      stafftype = json["staff_type"];
    }
  }
}
