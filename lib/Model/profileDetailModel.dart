// To parse this JSON data, do
//
//     final profileDetailModel = profileDetailModelFromJson(jsonString);

import 'dart:convert';

ProfileDetailModel profileDetailModelFromJson(String str) => ProfileDetailModel.fromJson(json.decode(str));

String profileDetailModelToJson(ProfileDetailModel data) => json.encode(data.toJson());

class ProfileDetailModel {
  List<String> chats;
  DateTime creationdate;
  String email;
  int followers;
  int following;
  String photourl;
  String username;

  ProfileDetailModel({
     this.chats,
     this.creationdate,
     this.email,
     this.followers,
     this.following,
     this.photourl,
     this.username,
  });

  factory ProfileDetailModel.fromJson(Map<String, dynamic> json) => ProfileDetailModel(
    chats: List<String>.from(json["chats"].map((x) => x)),
    creationdate: DateTime.parse(json["creationdate"]),
    email: json["email"],
    followers: json["followers"],
    following: json["following"],
    photourl: json["photourl"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "chats": List<dynamic>.from(chats.map((x) => x)),
    "creationdate": creationdate.toIso8601String(),
    "email": email,
    "followers": followers,
    "following": following,
    "photourl": photourl,
    "username": username,
  };
}
