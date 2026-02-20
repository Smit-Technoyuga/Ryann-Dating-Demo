// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_compatibility_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitCompatibilityReqModel _$SubmitCompatibilityReqModelFromJson(
  Map<String, dynamic> json,
) => SubmitCompatibilityReqModel(
  questionAnswers: (json['questionAnswers'] as List<dynamic>)
      .map(
        (e) => CompatibilityAnswerRequest.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$SubmitCompatibilityReqModelToJson(
  SubmitCompatibilityReqModel instance,
) => <String, dynamic>{'questionAnswers': instance.questionAnswers};

CompatibilityAnswerRequest _$CompatibilityAnswerRequestFromJson(
  Map<String, dynamic> json,
) => CompatibilityAnswerRequest(
  questionKey: json['questionKey'] as String,
  answers: (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CompatibilityAnswerRequestToJson(
  CompatibilityAnswerRequest instance,
) => <String, dynamic>{
  'questionKey': instance.questionKey,
  'answers': instance.answers,
};
