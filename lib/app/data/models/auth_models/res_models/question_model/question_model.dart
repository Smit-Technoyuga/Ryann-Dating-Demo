// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'question_model.g.dart';

QuestionModel deserializeQuestionModel(Map<String, dynamic> json) =>
    QuestionModel.fromJson(json);

Map<String, dynamic> serializeQuestionModel(QuestionModel model) =>
    model.toJson();

@JsonSerializable()
class QuestionModel extends ApiResponse {
  QuestionModel({this.data, required super.message, required super.success});

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  final QuestionList? data;

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class QuestionList {
  QuestionList({this.questions});

  factory QuestionList.fromJson(Map<String, dynamic> json) =>
      _$QuestionListFromJson(json);
  @JsonKey(name: 'questions')
  final List<Question>? questions;

  Map<String, dynamic> toJson() => _$QuestionListToJson(this);
}

@JsonSerializable()
class Question {
  Question({
    this.id,
    this.questionKey,
    this.title,
    this.answerType,
    this.category,
    this.impactLevel,
    this.isPrivate,
    this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'questionKey')
  final String? questionKey;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'answerType')
  final AnswerType? answerType;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'impactLevel')
  final String? impactLevel;
  @JsonKey(name: 'isPrivate')
  final bool? isPrivate;
  @JsonKey(name: 'options')
  final List<Option>? options;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

enum AnswerType {
  @JsonValue('single_select')
  SINGLE_SELECT,

  @JsonValue('multi_select')
  MULTI_SELECT,
}

final answerTypeValues = EnumValues({
  'single_select': AnswerType.SINGLE_SELECT,
  'multi_select': AnswerType.MULTI_SELECT,
});

@JsonSerializable()
class Option {
  Option({this.value, this.label, this.weight});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'weight')
  final int? weight;

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

class EnumValues<T> {
  EnumValues(this.map);
  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return map.map((k, v) => MapEntry(v, k));
  }
}
