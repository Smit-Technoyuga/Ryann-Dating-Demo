import 'package:json_annotation/json_annotation.dart';

part 'prompt_model.g.dart';

@JsonSerializable()
class PromptModel {
  PromptModel({
    this.id,
    this.question,
    this.category,
    this.categoryLabel,
    this.isActive,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory PromptModel.fromJson(Map<String, dynamic> json) =>
      _$PromptModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'question')
  final String? question;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'categoryLabel')
  final String? categoryLabel;
  @JsonKey(name: 'isActive')
  final int? isActive;
  @JsonKey(name: 'sortOrder')
  final int? sortOrder;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  Map<String, dynamic> toJson() => _$PromptModelToJson(this);
}
