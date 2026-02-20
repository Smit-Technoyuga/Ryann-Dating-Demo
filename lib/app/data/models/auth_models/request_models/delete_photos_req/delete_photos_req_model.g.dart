// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_photos_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePhotosReqModel _$DeletePhotosReqModelFromJson(
  Map<String, dynamic> json,
) => DeletePhotosReqModel(
  photoUrls: (json['photoUrls'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$DeletePhotosReqModelToJson(
  DeletePhotosReqModel instance,
) => <String, dynamic>{'photoUrls': instance.photoUrls};
