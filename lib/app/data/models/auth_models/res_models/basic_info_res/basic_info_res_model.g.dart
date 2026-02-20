// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicInfoRes _$BasicInfoResFromJson(Map<String, dynamic> json) => BasicInfoRes(
  data: json['data'] == null
      ? null
      : BasicInfoResModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  success: json['success'] as bool,
);

Map<String, dynamic> _$BasicInfoResToJson(BasicInfoRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BasicInfoResModel _$BasicInfoResModelFromJson(
  Map<String, dynamic> json,
) => BasicInfoResModel(
  nextStep: (json['nextStep'] as num?)?.toInt(),
  photos: (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  prompts: (json['prompts'] as List<dynamic>?)
      ?.map((e) => PromptModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  compatibilityRing: (json['compatibilityRing'] as List<dynamic>?)
      ?.map((e) => CompatibilityRingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BasicInfoResModelToJson(BasicInfoResModel instance) =>
    <String, dynamic>{
      'nextStep': instance.nextStep,
      'photos': instance.photos,
      'interests': instance.interests,
      'prompts': instance.prompts,
      'compatibilityRing': instance.compatibilityRing,
    };
