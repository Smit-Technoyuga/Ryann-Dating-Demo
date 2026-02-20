// To parse this JSON data, do
//
//     final sendOtpResModel = sendOtpResModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';
part 'send_otp_res_model.g.dart';

SendOtpRes deserializeSendOtpRes(Map<String, dynamic> str) =>
    SendOtpRes.fromJson(str);

@JsonSerializable()
class SendOtpRes extends ApiResponse {
  SendOtpRes({this.data, required super.message, required super.success});

  factory SendOtpRes.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResFromJson(json);

  final SendOtpResModel? data;

  Map<String, dynamic> toJson() => _$SendOtpResToJson(this);
}

@JsonSerializable()
class SendOtpResModel {
  SendOtpResModel({this.userId, this.isOtpSent, this.otp});

  factory SendOtpResModel.fromJson(Map<String, dynamic> json) =>
      _$SendOtpResModelFromJson(json);
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'isOtpSent')
  final bool? isOtpSent;
  @JsonKey(name: 'otp')
  final String? otp;

  Map<String, dynamic> toJson() => _$SendOtpResModelToJson(this);
}
