// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.data,
  });

  UserData? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.phone,
    this.imagePath,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? profileImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? country;
  String? phone;
  String? imagePath;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        profileImage: json["profile_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        country: json["country"],
        phone: json["phone"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "profile_image": profileImage,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "country": country,
        "phone": phone,
        "image_path": imagePath,
      };
}
