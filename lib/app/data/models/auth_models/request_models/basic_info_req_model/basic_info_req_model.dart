import 'package:json_annotation/json_annotation.dart';

part 'basic_info_req_model.g.dart';

Map<String, dynamic> serializeBasicInfoReqModel(BasicInfoReqModel data) =>
    data.toJson();

@JsonSerializable()
class BasicInfoReqModel {
  BasicInfoReqModel({
    required this.firstName,
    required this.dateOfBirth,
    required this.gender,
  });

  factory BasicInfoReqModel.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoReqModelFromJson(json);

  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'dateOfBirth')
  final String dateOfBirth;
  @JsonKey(name: 'gender')
  final String gender;

  Map<String, dynamic> toJson() => _$BasicInfoReqModelToJson(this);
}
