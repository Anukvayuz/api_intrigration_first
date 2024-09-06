// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    final int? userId;
    final int? id;
    final String? title;
    final String? body;

    Welcome({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    Welcome copyWith({
        int? userId,
        int? id,
        String? title,
        String? body,
    }) => 
        Welcome(
            userId: userId ?? this.userId,
            id: id ?? this.id,
            title: title ?? this.title,
            body: body ?? this.body,
        );

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
