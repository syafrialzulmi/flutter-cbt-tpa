import 'dart:convert';

class NilaiResponseModel {
  final String message;
  final int nilai;
  final int benar;
  final int salah;

  NilaiResponseModel({
    required this.message,
    required this.nilai,
    required this.benar,
    required this.salah,
  });

  factory NilaiResponseModel.fromJson(String str) =>
      NilaiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NilaiResponseModel.fromMap(Map<String, dynamic> json) =>
      NilaiResponseModel(
        message: json["message"],
        nilai: json["nilai"],
        benar: json["benar"],
        salah: json["salah"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "nilai": nilai,
        "benar": benar,
        "salah": salah,
      };
}
