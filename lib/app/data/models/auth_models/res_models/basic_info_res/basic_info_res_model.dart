import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_ring_model/compatibility_ring_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/interest_model/interest_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'basic_info_res_model.g.dart';

BasicInfoRes deserializeBasicInfoRes(Map<String, dynamic> json) =>
    BasicInfoRes.fromJson(json);

@JsonSerializable()
class BasicInfoRes extends ApiResponse {
  BasicInfoRes({this.data, required super.message, required super.success});

  factory BasicInfoRes.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoResFromJson(json);

  final BasicInfoResModel? data;

  Map<String, dynamic> toJson() => _$BasicInfoResToJson(this);
}

@JsonSerializable()
class BasicInfoResModel {
  BasicInfoResModel({
    this.nextStep,
    this.photos,
    this.interests,
    this.prompts,
    this.compatibilityRing,
  });

  factory BasicInfoResModel.fromJson(Map<String, dynamic> json) =>
      _$BasicInfoResModelFromJson(json);

  @JsonKey(name: 'nextStep')
  final int? nextStep;
  @JsonKey(name: 'photos')
  final List<String>? photos;
  @JsonKey(name: 'interests')
  final List<InterestModel>? interests;
  @JsonKey(name: 'prompts')
  final List<PromptModel>? prompts;
  @JsonKey(name: 'compatibilityRing')
  final List<CompatibilityRingModel>? compatibilityRing;

  Map<String, dynamic> toJson() => _$BasicInfoResModelToJson(this);
}
