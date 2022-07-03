// To parse this JSON data, do
//
//     final device = deviceFromJson(jsonString);

import 'dart:convert';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
    Device({
        this.id,
        this.topic,
    });

    String? id;
    String? topic;

    factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        topic: json["topic"] == null ? null : json["topic"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "topic": topic == null ? null : topic,
    };
}
