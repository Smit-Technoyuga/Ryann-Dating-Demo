// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompatibilityAnswerModel _$CompatibilityAnswerModelFromJson(
  Map<String, dynamic> json,
) => CompatibilityAnswerModel(
  questionKey: json['questionKey'] as String?,
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
);

Map<String, dynamic> _$CompatibilityAnswerModelToJson(
  CompatibilityAnswerModel instance,
) => <String, dynamic>{
  'questionKey': instance.questionKey,
  'answers': instance.answers,
  'sortOrder': instance.sortOrder,
};
