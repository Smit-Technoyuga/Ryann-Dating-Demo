// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      data: json['data'] == null
          ? null
          : QuestionList.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

QuestionList _$QuestionListFromJson(Map<String, dynamic> json) => QuestionList(
  questions: (json['questions'] as List<dynamic>?)
      ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionListToJson(QuestionList instance) =>
    <String, dynamic>{'questions': instance.questions};

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: json['_id'] as String?,
  questionKey: json['questionKey'] as String?,
  title: json['title'] as String?,
  answerType: $enumDecodeNullable(_$AnswerTypeEnumMap, json['answerType']),
  category: json['category'] as String?,
  impactLevel: json['impactLevel'] as String?,
  isPrivate: json['isPrivate'] as bool?,
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  '_id': instance.id,
  'questionKey': instance.questionKey,
  'title': instance.title,
  'answerType': _$AnswerTypeEnumMap[instance.answerType],
  'category': instance.category,
  'impactLevel': instance.impactLevel,
  'isPrivate': instance.isPrivate,
  'options': instance.options,
};

const _$AnswerTypeEnumMap = {
  AnswerType.SINGLE_SELECT: 'single_select',
  AnswerType.MULTI_SELECT: 'multi_select',
};

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
  value: json['value'] as String?,
  label: json['label'] as String?,
  weight: (json['weight'] as num?)?.toInt(),
);

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
  'value': instance.value,
  'label': instance.label,
  'weight': instance.weight,
};
