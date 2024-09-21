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
  final bool areHavePicture;
  final List<MenuItem> data;

  Result({
    required this.areHavePicture,
    required this.data,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        areHavePicture: json["areHavePicture"],
        data: json["data"] == null
            ? []
            : List<MenuItem>.from(
                json["data"]!.map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "areHavePicture": areHavePicture,
        "data":List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MenuItem {
  final int id;
  final String type;
  final String name;
  final int price;
  final String imgurl;

  MenuItem({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.imgurl,
  });

  factory MenuItem.fromRawJson(String str) =>
      MenuItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
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
