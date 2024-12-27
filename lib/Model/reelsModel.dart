// To parse this JSON data, do
//
//     final reelsModel = reelsModelFromJson(jsonString);

import 'dart:convert';

Map<String, ReelsModel> reelsModelFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, ReelsModel>(k, ReelsModel.fromJson(v)));

String reelsModelToJson(Map<String, ReelsModel> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ReelsModel {
  int tags;
  int comments;
  String description;
  int likes;
  String ownerDisplayname;
  String ownerProfileImage;
  String ownerid;
  String videourl;

  ReelsModel({
     this.tags,
     this.comments,
     this.description,
     this.likes,
     this.ownerDisplayname,
     this.ownerProfileImage,
     this.ownerid,
     this.videourl,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) => ReelsModel(
    tags: json["Tags"],
    comments: json["comments"],
    description: json["description"],
    likes: json["likes"],
    ownerDisplayname: json["owner_displayname"],
    ownerProfileImage: json["owner_profile_image"],
    ownerid: json["ownerid"],
    videourl: json["videourl"],
  );

  Map<String, dynamic> toJson() => {
    "Tags": tags,
    "comments": comments,
    "description": description,
    "likes": likes,
    "owner_displayname": ownerDisplayname,
    "owner_profile_image": ownerProfileImage,
    "ownerid": ownerid,
    "videourl": videourl,
  };
}
