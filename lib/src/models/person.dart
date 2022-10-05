// To parse this JSON data, do
//
//     final person = personFromJson(jsonString);

import 'dart:convert';

People personFromJson(String str) => People.fromJson(json.decode(str));

// String personToJson(Person data) => json.encode(data.toJson());

class People {
  People({
    this.adult,
    this.biography,
    this.gender,
    this.id,
    this.name,
    this.profilePath,
  });

  bool? adult;
  String? biography;
  int? gender;
  int? id;
  String? name;
  String? profilePath;

  factory People.fromJson(Map<String, dynamic> json) => People(
        adult: json["adult"] == null ? null : json["adult"],
        biography: json["biography"] == null ? null : json["biography"],
        gender: json["gender"] == null ? null : json["gender"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "biography": biography == null ? null : biography,
        "gender": gender == null ? null : gender,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "profile_path": profilePath == null ? null : profilePath,
      };
}
