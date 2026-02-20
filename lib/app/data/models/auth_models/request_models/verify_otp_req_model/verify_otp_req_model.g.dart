// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpReqModel _$VerifyOtpReqModelFromJson(Map<String, dynamic> json) =>
    VerifyOtpReqModel(
      phoneNumber: json['phoneNumber'] as String?,
      countryCode: json['countryCode'] as String?,
      isoCode: json['isoCode'] as String?,
      otp: json['otp'] as String?,
      type: (json['type'] as num?)?.toInt(),
      country: json['country'] as String?,
    );

Map<String, dynamic> _$VerifyOtpReqModelToJson(VerifyOtpReqModel instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'isoCode': instance.isoCode,
      'otp': instance.otp,
      'type': instance.type,
      'country': instance.country,
    };
