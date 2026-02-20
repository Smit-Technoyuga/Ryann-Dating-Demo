// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRes _$VerifyOtpResFromJson(Map<String, dynamic> json) => VerifyOtpRes(
  data: json['data'] == null
      ? null
      : VerifyOtpResModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  success: json['success'] as bool,
);

Map<String, dynamic> _$VerifyOtpResToJson(VerifyOtpRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

VerifyOtpResModel _$VerifyOtpResModelFromJson(Map<String, dynamic> json) =>
    VerifyOtpResModel(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyOtpResModelToJson(VerifyOtpResModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String?,
  isOnboardingCompleted: (json['isOnboardingCompleted'] as num?)?.toInt(),
  isUserInWaitingList: (json['isUserInWaitingList'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'isOnboardingCompleted': instance.isOnboardingCompleted,
  'isUserInWaitingList': instance.isUserInWaitingList,
};
