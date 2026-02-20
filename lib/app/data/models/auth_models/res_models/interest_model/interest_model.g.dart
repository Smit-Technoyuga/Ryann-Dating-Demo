// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterestModel _$InterestModelFromJson(Map<String, dynamic> json) =>
    InterestModel(
      id: json['_id'] as String?,
      category: json['category'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InterestModelToJson(InterestModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'options': instance.options,
      'sortOrder': instance.sortOrder,
    };
