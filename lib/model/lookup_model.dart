// To parse this JSON data, do
//
//     final lookupModel = lookupModelFromJson(jsonString);

import 'dart:convert';

LookupModel lookupModelFromJson(String str) => LookupModel.fromJson(json.decode(str));

String lookupModelToJson(LookupModel data) => json.encode(data.toJson());

class LookupModel {
    List<Item>? items;
    bool? hasMore;
    int? limit;
    int? offset;
    int? count;
    List<Link>? links;

    LookupModel({
        this.items,
        this.hasMore,
        this.limit,
        this.offset,
        this.count,
        this.links,
    });

    factory LookupModel.fromJson(Map<String, dynamic> json) => LookupModel(
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        hasMore: json["hasMore"],
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    };
}

class Item {
    List<Blood>? gender;
    List<Country>? marital;
    List<Country>? religion;
    List<Blood>? blood;
    List<Country>? country;
    List<Country>? relation;
    String? uploadDir;
    List<Gallery>? gallery;

    Item({
        this.gender,
        this.marital,
        this.religion,
        this.blood,
        this.country,
        this.relation,
        this.uploadDir,
        this.gallery,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        gender: json["gender"] == null ? [] : List<Blood>.from(json["gender"]!.map((x) => Blood.fromJson(x))),
        marital: json["marital"] == null ? [] : List<Country>.from(json["marital"]!.map((x) => Country.fromJson(x))),
        religion: json["religion"] == null ? [] : List<Country>.from(json["religion"]!.map((x) => Country.fromJson(x))),
        blood: json["blood"] == null ? [] : List<Blood>.from(json["blood"]!.map((x) => Blood.fromJson(x))),
        country: json["country"] == null ? [] : List<Country>.from(json["country"]!.map((x) => Country.fromJson(x))),
        relation: json["relation"] == null ? [] : List<Country>.from(json["relation"]!.map((x) => Country.fromJson(x))),
        uploadDir: json["upload_dir"],
        gallery: json["gallery"] == null ? [] : List<Gallery>.from(json["gallery"]!.map((x) => Gallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "gender": gender == null ? [] : List<dynamic>.from(gender!.map((x) => x.toJson())),
        "marital": marital == null ? [] : List<dynamic>.from(marital!.map((x) => x.toJson())),
        "religion": religion == null ? [] : List<dynamic>.from(religion!.map((x) => x.toJson())),
        "blood": blood == null ? [] : List<dynamic>.from(blood!.map((x) => x.toJson())),
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x.toJson())),
        "relation": relation == null ? [] : List<dynamic>.from(relation!.map((x) => x.toJson())),
        "upload_dir": uploadDir,
        "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x.toJson())),
    };
}

class Blood {
    String? rId;
    String? rName;

    Blood({
        this.rId,
        this.rName,
    });

    factory Blood.fromJson(Map<String, dynamic> json) => Blood(
        rId: json["r_id"],
        rName: json["r_name"],
    );

    Map<String, dynamic> toJson() => {
        "r_id": rId,
        "r_name": rName,
    };
}

class Country {
    int? rId;
    String? rName;

    Country({
        this.rId,
        this.rName,
    });

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        rId: json["r_id"],
        rName: json["r_name"],
    );

    Map<String, dynamic> toJson() => {
        "r_id": rId,
        "r_name": rName,
    };
}

class Gallery {
    String? fncImgDirPhotoLoca;

    Gallery({
        this.fncImgDirPhotoLoca,
    });

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        fncImgDirPhotoLoca: json["fnc_img_dir||photo_loca"],
    );

    Map<String, dynamic> toJson() => {
        "fnc_img_dir||photo_loca": fncImgDirPhotoLoca,
    };
}

class Link {
    String? rel;
    String? href;

    Link({
        this.rel,
        this.href,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
    );

    Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
    };
}
