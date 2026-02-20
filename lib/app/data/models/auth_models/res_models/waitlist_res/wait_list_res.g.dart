// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wait_list_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitListRes _$WaitListResFromJson(Map<String, dynamic> json) => WaitListRes(
  data: json['data'] == null
      ? null
      : WaitListResModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  success: json['success'] as bool,
);

Map<String, dynamic> _$WaitListResToJson(WaitListRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

WaitListResModel _$WaitListResModelFromJson(Map<String, dynamic> json) =>
    WaitListResModel(
      allowNext: json['allowNext'] as bool?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$WaitListResModelToJson(WaitListResModel instance) =>
    <String, dynamic>{
      'allowNext': instance.allowNext,
      'userId': instance.userId,
    };
