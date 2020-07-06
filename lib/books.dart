// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

//String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  String kind;
  int totalItems;
  List<Item> items;

  Book({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        kind: json["kind"]==null?"kind":json["kind"],
        totalItems: json["totalItems"]==null?0:json["totalItems"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

//  Map<String, dynamic> toJson() => {
//        "kind": kind,
//        "totalItems": totalItems,
//        "items": List<dynamic>.from(items.map((x) => x.toJson())),
//      };
}

class Item {
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;

  Item({
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
      );

//  Map<String, dynamic> toJson() => {
//        "id": id,
//        "etag": etag,
//        "selfLink": selfLink,
//        "volumeInfo": volumeInfo.toJson(),
//      };
}

class VolumeInfo {
  String title;
  List<String> authors;
  String description;
  double averageRating;
  ImageLinks imageLinks;
  String infoLink;

  VolumeInfo({
    this.title,
    this.authors,
    this.description,
    this.averageRating,
    this.imageLinks,
    this.infoLink,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"]==null?"Title":json['title'],

        authors: json["authors"]==null?["No author details available"]:List<String>.from(json["authors"].map((x) => x)),
        description: json["description"]==null?"Description":json["description"],
        averageRating: json["averageRating"] == null
            ? null
            : json["averageRating"].toDouble(),
        imageLinks: json["imageLinks"] == null
            ? null
            : ImageLinks.fromJson(json["imageLinks"]),
        infoLink: json["infoLink"]==null?"link":json["infoLink"],
      );

//  Map<String, dynamic> toJson() => {
//        "title": title,
//        "authors": List<dynamic>.from(authors.map((x) => x)),
//        "description": description,
//        "averageRating": averageRating == null ? 0.0 : averageRating,
//        "imageLinks": imageLinks == null ? null: imageLinks.toJson(),
//        "infoLink": infoLink==null?"link":infoLink,
//      };
}

class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"]==null?null:json["smallThumbnail"],
        thumbnail: json["thumbnail"]==null?null:json["thumbnail"],
      );

//  Map<String, dynamic> toJson() => {
//        "smallThumbnail": smallThumbnail==null?null:smallThumbnail,
//        "thumbnail": thumbnail==null?null:thumbnail,
//      };
}
