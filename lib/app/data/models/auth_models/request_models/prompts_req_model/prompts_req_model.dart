import 'package:json_annotation/json_annotation.dart';

part 'prompts_req_model.g.dart';

Map<String, dynamic> serializePromptsReqModel(PromptsReqModel data) =>
    data.toJson();

@JsonSerializable()
class PromptsReqModel {
  PromptsReqModel({required this.prompts});

  factory PromptsReqModel.fromJson(Map<String, dynamic> json) =>
      _$PromptsReqModelFromJson(json);

  @JsonKey(name: 'prompts')
  final List<Map<String, dynamic>> prompts;

  Map<String, dynamic> toJson() => _$PromptsReqModelToJson(this);
}
