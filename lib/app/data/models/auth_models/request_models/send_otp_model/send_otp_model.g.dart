// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpModel _$SendOtpModelFromJson(Map<String, dynamic> json) => SendOtpModel(
  type: (json['type'] as num?)?.toInt(),
  userId: json['userId'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  countryCode: json['countryCode'] as String?,
  isoCode: json['isoCode'] as String?,
);

Map<String, dynamic> _$SendOtpModelToJson(SendOtpModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'userId': instance.userId,
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
      'isoCode': instance.isoCode,
    };
