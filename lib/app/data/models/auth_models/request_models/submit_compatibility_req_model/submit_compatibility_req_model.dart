import 'package:json_annotation/json_annotation.dart';

part 'submit_compatibility_req_model.g.dart';

SubmitCompatibilityReqModel deserializeSubmitCompatibilityReqModel(
  Map<String, dynamic> json,
) => SubmitCompatibilityReqModel.fromJson(json);

Map<String, dynamic> serializeSubmitCompatibilityReqModel(
  SubmitCompatibilityReqModel model,
) => model.toJson();

@JsonSerializable()
class SubmitCompatibilityReqModel {
  SubmitCompatibilityReqModel({required this.questionAnswers});

  factory SubmitCompatibilityReqModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitCompatibilityReqModelFromJson(json);

  @JsonKey(name: 'questionAnswers')
  final List<CompatibilityAnswerRequest> questionAnswers;

  Map<String, dynamic> toJson() => _$SubmitCompatibilityReqModelToJson(this);
}

@JsonSerializable()
class CompatibilityAnswerRequest {
  CompatibilityAnswerRequest({
    required this.questionKey,
    required this.answers,
  });

  factory CompatibilityAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$CompatibilityAnswerRequestFromJson(json);

  @JsonKey(name: 'questionKey')
  final String questionKey;
  @JsonKey(name: 'answers')
  final List<String> answers;

  Map<String, dynamic> toJson() => _$CompatibilityAnswerRequestToJson(this);
}
