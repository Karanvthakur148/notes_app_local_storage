// To parse this JSON data, do
//
//     final noteModel = noteModelFromJson(jsonString);

import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  NoteModel({
    this.title,
    this.subTitle,
    this.date,
    this.id,
    this.colorId,
  });

  String? title;
  String? subTitle;
  String? date;
  String? id;
  String? colorId;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        title: json["title"],
        subTitle: json["subTitle"],
        date: json["date"],
        id: json["id"],
        colorId: json["color_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "date": date,
        "id": id,
        "color_id": colorId,
      };
}
