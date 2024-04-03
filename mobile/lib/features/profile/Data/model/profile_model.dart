import '../../Domain/Entite/profile_entitie.dart';

class ProfileModel extends ProfileEntitie {
  const ProfileModel({
    required super.user_id,
    required super.name,
    required super.profile_image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user_id: json['user_id'],
      name: json['name'],
      profile_image: json['profile_image'],
    );
  }

  Map<String, dynamic> tojson() {
    return {};
  }
}