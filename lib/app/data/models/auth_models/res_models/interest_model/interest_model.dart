import 'package:json_annotation/json_annotation.dart';

part 'interest_model.g.dart';

@JsonSerializable()
class InterestModel {
  InterestModel({this.id, this.category, this.options, this.sortOrder});

  factory InterestModel.fromJson(Map<String, dynamic> json) =>
      _$InterestModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'options')
  final List<String>? options;
  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  Map<String, dynamic> toJson() => _$InterestModelToJson(this);
}
