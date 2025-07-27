import 'dart:convert';

PerfumeModel perfumeModelFromJson(String str) =>
    PerfumeModel.fromJson(json.decode(str));

String perfumeModelToJson(PerfumeModel data) => json.encode(data.toJson());

class PerfumeModel {
  int errorCode;
  String message;
  Data data;

  PerfumeModel({
    required this.errorCode,
    required this.message,
    required this.data,
  });

  factory PerfumeModel.fromJson(Map<String, dynamic> json) => PerfumeModel(
    errorCode: json["error_code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error_code": errorCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<Map<String, dynamic>> homeFields;
  int notificationCount;

  Data({required this.homeFields, required this.notificationCount});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    homeFields: List<Map<String, dynamic>>.from(
      json["home_fields"].map((x) => (x)),
    ),
    notificationCount: json["notification_count"],
  );

  Map<String, dynamic> toJson() => {
    "home_fields": List<Map<String, dynamic>>.from(homeFields.map((x) => x)),
    "notification_count": notificationCount,
  };
}
