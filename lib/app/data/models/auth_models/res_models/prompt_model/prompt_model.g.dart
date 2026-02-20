// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromptModel _$PromptModelFromJson(Map<String, dynamic> json) => PromptModel(
  id: json['_id'] as String?,
  question: json['question'] as String?,
  category: json['category'] as String?,
  categoryLabel: json['categoryLabel'] as String?,
  isActive: (json['isActive'] as num?)?.toInt(),
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$PromptModelToJson(PromptModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'category': instance.category,
      'categoryLabel': instance.categoryLabel,
      'isActive': instance.isActive,
      'sortOrder': instance.sortOrder,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
