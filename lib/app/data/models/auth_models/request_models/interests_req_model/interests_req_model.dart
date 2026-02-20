import 'package:json_annotation/json_annotation.dart';

part 'interests_req_model.g.dart';

Map<String, dynamic> serializeInterestsReqModel(InterestsReqModel data) =>
    data.toJson();

@JsonSerializable()
class InterestsReqModel {
  InterestsReqModel({
    required this.interests,
    required this.sharedInterestImportance,
  });

  factory InterestsReqModel.fromJson(Map<String, dynamic> json) =>
      _$InterestsReqModelFromJson(json);

  @JsonKey(name: 'interests')
  final List<String> interests;
  @JsonKey(name: 'sharedInterestImportance')
  final String sharedInterestImportance;

  Map<String, dynamic> toJson() => _$InterestsReqModelToJson(this);
}
