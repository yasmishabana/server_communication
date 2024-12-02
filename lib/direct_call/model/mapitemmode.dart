class MapdataModel {
  int? id;
  String? title;

  MapdataModel({
    this.id,
    this.title,
  });

  factory MapdataModel.fromJson(Map<String, dynamic> json) => MapdataModel(
        id: json["id"],
        title: json["descrption"],
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "descrption": descrption,
  // };
}
