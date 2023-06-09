// To parse this JSON data, do
//
//     final instaPostmodel = instaPostmodelFromJson(jsonString);

import 'dart:convert';

import 'package:demo_chat/Model/commentModel.dart';

InstaPostmodel instaPostmodelFromJson(String str) => InstaPostmodel.fromJson(json.decode(str));

String instaPostmodelToJson(InstaPostmodel data) => json.encode(data.toJson());

class InstaPostmodel {
  InstaPostmodel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  List<Datum> data;
  int total;
  int page;
  int limit;

  factory InstaPostmodel.fromJson(Map<String, dynamic> json) => InstaPostmodel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
  };
}

class Datum {


  Datum({
    required this.id,
    required this.image,
    required this.likes,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
    this.commentlist,
  });

  String id;
  String image;
  int likes;
  List<String> tags;
  String text;
  DateTime publishDate;
  Owner owner;
  var commentlist;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"]!=null ? json["image"] :"" ,
    likes: json["likes"]!=null ?json["likes"]:0,
    tags: json["tags"] !=null ?List<String>.from(json["tags"].map((x) => x)):[],
    text: json["text"],
    publishDate: DateTime.parse(json["publishDate"]),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "likes": likes,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "text": text,
    "publishDate": publishDate.toIso8601String(),
    "owner": owner.toJson(),
  };
}

class Owner {
  Owner({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  String id;
  Title? title;
  String firstName;
  String lastName;
  String picture;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    title: titleValues.map![json["title"]],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": titleValues.reverse![title],
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };
}

enum Title { MS, MISS, MRS, MR }

final titleValues = EnumValues({
  "miss": Title.MISS,
  "mr": Title.MR,
  "mrs": Title.MRS,
  "ms": Title.MS
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
