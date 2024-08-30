// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
     this.data,
  });

  List<commentsDetails> data;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    data: List<commentsDetails>.from(json["data"].map((x) => commentsDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class commentsDetails {
  commentsDetails({
     this.id = '',
     this.message = '',
      this.owner,
     this.post = '',
      this.publishDate ,
  });

  String id;
  String message;
  Owner owner;
  String post;
  DateTime publishDate;

  factory commentsDetails.fromJson(Map<String, dynamic> json) => commentsDetails(
    id: json["id"],
    message: json["message"],
    owner: Owner.fromJson(json["owner"]),
    post: json["post"],
    publishDate: DateTime.parse(json["publishDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "owner": owner.toJson(),
    "post": post,
    "publishDate": publishDate.toIso8601String(),
  };
}

class Owner {
  Owner({
     this.id,
     this.title,
     this.firstName,
     this.lastName,
     this.picture,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };
}
