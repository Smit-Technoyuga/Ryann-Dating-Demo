// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpRes _$SendOtpResFromJson(Map<String, dynamic> json) => SendOtpRes(
  data: json['data'] == null
      ? null
      : SendOtpResModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  success: json['success'] as bool,
);

Map<String, dynamic> _$SendOtpResToJson(SendOtpRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

SendOtpResModel _$SendOtpResModelFromJson(Map<String, dynamic> json) =>
    SendOtpResModel(
      userId: json['userId'] as String?,
      isOtpSent: json['isOtpSent'] as bool?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$SendOtpResModelToJson(SendOtpResModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isOtpSent': instance.isOtpSent,
      'otp': instance.otp,
    };
