// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_photos_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPhotosRes _$VerifyPhotosResFromJson(Map<String, dynamic> json) =>
    VerifyPhotosRes(
      data: json['data'] == null
          ? null
          : VerifyPhotosData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$VerifyPhotosResToJson(VerifyPhotosRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

VerifyPhotosData _$VerifyPhotosDataFromJson(Map<String, dynamic> json) =>
    VerifyPhotosData(
      nextStep: (json['nextStep'] as num?)?.toInt(),
      intentions: (json['intentions'] as List<dynamic>?)
          ?.map((e) => IntentionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VerifyPhotosDataToJson(VerifyPhotosData instance) =>
    <String, dynamic>{
      'nextStep': instance.nextStep,
      'intentions': instance.intentions,
    };

IntentionModel _$IntentionModelFromJson(Map<String, dynamic> json) =>
    IntentionModel(
      id: json['_id'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IntentionModelToJson(IntentionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
    };
