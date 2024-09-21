import 'dart:convert';

class MenuItems {
  Result? result;

  MenuItems({
    this.result,
  });

  factory MenuItems.fromRawJson(String str) =>
      MenuItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItems.fromJson(Map<String, dynamic> json) => MenuItems(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };
}

class Result {
  bool? areHavePicture;
  List<Menu>? data;

  Result({
    this.areHavePicture,
    this.data,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        areHavePicture: json["areHavePicture"],
        data: json["data"] == null
            ? []
            : List<Menu>.from(json["data"]!.map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areHavePicture": areHavePicture,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Menu {
  int? id;
  String? type;
  String? name;
  int? price;
  String? imgurl;

  Menu({
    this.id,
    this.type,
    this.name,
    this.price,
    this.imgurl,
  });

  factory Menu.fromRawJson(String str) => Menu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        price: json["price"],
        imgurl: json["imgurl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "price": price,
        "imgurl": imgurl,
      };
}
