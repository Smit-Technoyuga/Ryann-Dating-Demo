import 'package:json_annotation/json_annotation.dart';

part 'compatibility_ring_model.g.dart';

@JsonSerializable()
class CompatibilityRingModel {
  CompatibilityRingModel({this.id, this.label, this.subtitle, this.sortOrder});

  factory CompatibilityRingModel.fromJson(Map<String, dynamic> json) =>
      _$CompatibilityRingModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'subtitle')
  final String? subtitle;
  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  Map<String, dynamic> toJson() => _$CompatibilityRingModelToJson(this);
}
