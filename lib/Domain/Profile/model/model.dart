import 'profile.dart';

class Model {
  String? status;
  Profile? profile;

  Model({this.status, this.profile});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    status: json['status'] as String?,
    profile:
        json['profile'] == null
            ? null
            : Profile.fromJson(json['profile'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'profile': profile?.toJson(),
  };
}
