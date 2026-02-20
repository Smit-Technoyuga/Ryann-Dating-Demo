// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompts_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromptsReqModel _$PromptsReqModelFromJson(Map<String, dynamic> json) =>
    PromptsReqModel(
      prompts: (json['prompts'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$PromptsReqModelToJson(PromptsReqModel instance) =>
    <String, dynamic>{'prompts': instance.prompts};
