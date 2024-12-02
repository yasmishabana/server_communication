import 'dart:developer';

class ListdataModel {
  int? id;
  String? title;
  String? description;
  String? image;

  ListdataModel({this.id, this.title, this.description, this.image});

  factory ListdataModel.fromJson(Map<String, dynamic> json) {
    log("ListdataModel======"+ json["title"]);
    return ListdataModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"]);
  }
  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "title": title,
  //     "description": description,
  // };
}
