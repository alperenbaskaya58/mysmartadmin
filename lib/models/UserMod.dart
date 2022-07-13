// To parse this JSON data, do
//
//     final userMod = userModFromJson(jsonString);

import 'dart:convert';

UserMod userModFromJson(String str) => UserMod.fromJson(json.decode(str));

String userModToJson(UserMod data) => json.encode(data.toJson());

class UserMod {
    UserMod({
        this.uid,
        this.email,
        this.notifToken,
        this.topics,
    });

    String? uid;
    String? email;
    String? notifToken;
    List<Topic>? topics;

    factory UserMod.fromJson(Map<String, dynamic> json) => UserMod(
        uid: json["uid"] == null ? null : json["uid"],
        email: json["email"] == null ? null : json["email"],
        notifToken: json["notifToken"] == null ? null : json["notifToken"],
        topics: json["topics"] == null ? null : List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "email": email == null ? null : email,
        "notifToken": notifToken == null ? null : notifToken,
        "topics": topics == null ? null : List<dynamic>.from(topics!.map((x) => x.toJson())),
    };
}

class Topic {
    Topic({
        this.name,
        this.topic,
    });

    String? name;
    String? topic;

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        name: json["name"] == null ? null : json["name"],
        topic: json["topic"] == null ? null : json["topic"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "topic": topic == null ? null : topic,
    };
}
