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
    List<String>? topics;

    factory UserMod.fromJson(Map<String, dynamic> json) => UserMod(
        uid: json["uid"] == null ? null : json["uid"],
        email: json["email"] == null ? null : json["email"],
        notifToken: json["notifToken"] == null ? null : json["notifToken"],
        topics: json["topics"] == null ? null : List<String>.from(json["topics"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "email": email == null ? null : email,
        "notifToken": notifToken == null ? null : notifToken,
        "topics": topics == null ? null : List<dynamic>.from(topics!.map((x) => x)),
    };
}
