import 'package:json_annotation/json_annotation.dart';

part 'compatibility_answer_model.g.dart';

@JsonSerializable()
class CompatibilityAnswerModel {
  CompatibilityAnswerModel({this.questionKey, this.answers, this.sortOrder});

  factory CompatibilityAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$CompatibilityAnswerModelFromJson(json);

  @JsonKey(name: 'questionKey')
  final String? questionKey;
  @JsonKey(name: 'answers')
  final List<String>? answers;
  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  Map<String, dynamic> toJson() => _$CompatibilityAnswerModelToJson(this);
}
