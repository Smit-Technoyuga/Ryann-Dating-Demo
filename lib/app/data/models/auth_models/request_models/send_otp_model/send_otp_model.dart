// To parse this JSON data, do
//
//     final loginReqModel = loginReqModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'send_otp_model.g.dart';

Map<String, dynamic> serializeSendOtpModel(SendOtpModel data) => data.toJson();

@JsonSerializable()
class SendOtpModel {
  SendOtpModel({
    this.type,
    this.userId,
    this.phoneNumber,
    this.countryCode,
    this.isoCode,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpModelFromJson(json);
  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'isoCode')
  final String? isoCode;

  Map<String, dynamic> toJson() {
    final json = _$SendOtpModelToJson(this);

    // 🔥 REMOVE empty string values
    json.removeWhere((key, value) => value?.toString().trim().isEmpty ?? true);

    return json;
  }
}
