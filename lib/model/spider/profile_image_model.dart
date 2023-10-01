// To parse this JSON data, do
//
//     final profileImageModel = profileImageModelFromJson(jsonString);

import 'dart:convert';

ProfileImageModel profileImageModelFromJson(String str) => ProfileImageModel.fromJson(json.decode(str));

String profileImageModelToJson(ProfileImageModel data) => json.encode(data.toJson());

class ProfileImageModel {
    int? statusCode;
    List<ListResponse>? listResponse;

    ProfileImageModel({
        this.statusCode,
        this.listResponse,
    });

    factory ProfileImageModel.fromJson(Map<String, dynamic> json) => ProfileImageModel(
        statusCode: json["statusCode"],
        listResponse: json["listResponse"] == null ? [] : List<ListResponse>.from(json["listResponse"]!.map((x) => ListResponse.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "listResponse": listResponse == null ? [] : List<dynamic>.from(listResponse!.map((x) => x.toJson())),
    };
}

class ListResponse {
    String? fileName;
    String? fileDownloadUri;
    String? filePreviewUri;
    String? filePath;
    String? msg;
    String? fileType;
    int? size;

    ListResponse({
        this.fileName,
        this.fileDownloadUri,
        this.filePreviewUri,
        this.filePath,
        this.msg,
        this.fileType,
        this.size,
    });

    factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
        fileName: json["fileName"],
        fileDownloadUri: json["fileDownloadUri"],
        filePreviewUri: json["filePreviewUri"],
        filePath: json["filePath"],
        msg: json["msg"],
        fileType: json["fileType"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileDownloadUri": fileDownloadUri,
        "filePreviewUri": filePreviewUri,
        "filePath": filePath,
        "msg": msg,
        "fileType": fileType,
        "size": size,
    };
}
