// To parse this JSON data, do
//
//     final youModel = youModelFromJson(jsonString);

import 'dart:convert';

List<YouModel> youModelFromJson(String str) => List<YouModel>.from(json.decode(str).map((x) => YouModel.fromJson(x)));

String youModelToJson(List<YouModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YouModel {
    String columnName;

    YouModel({
        this.columnName,
    });

    factory YouModel.fromJson(Map<String, dynamic> json) => YouModel(
        columnName: json["column_name"],
    );

    Map<String, dynamic> toJson() => {
        "column_name": columnName,
    };
}