import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_req_model.g.dart';

Map<String, dynamic> serializeVerifyOtpReqModel(VerifyOtpReqModel data) =>
    data.toJson();

@JsonSerializable()
class VerifyOtpReqModel {
  VerifyOtpReqModel({
    this.phoneNumber,
    this.countryCode,
    this.isoCode,
    this.otp,
    this.type,
    this.country,
  });

  factory VerifyOtpReqModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpReqModelFromJson(json);

  @JsonKey(name: 'phoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'isoCode')
  final String? isoCode;
  @JsonKey(name: 'otp')
  final String? otp;
  @JsonKey(name: 'type')
  final int? type;
  @JsonKey(name: 'country')
  final String? country;

  Map<String, dynamic> toJson() {
    final data = _$VerifyOtpReqModelToJson(this);
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
