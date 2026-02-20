import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'verify_photos_res_model.g.dart';

VerifyPhotosRes deserializeVerifyPhotosRes(Map<String, dynamic> data) =>
    VerifyPhotosRes.fromJson(data);

Map<String, dynamic> serializeVerifyPhotosRes(VerifyPhotosRes data) =>
    data.toJson();

@JsonSerializable()
class VerifyPhotosRes extends ApiResponse {
  VerifyPhotosRes({this.data, required super.message, required super.success});

  factory VerifyPhotosRes.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhotosResFromJson(json);

  final VerifyPhotosData? data;

  Map<String, dynamic> toJson() => _$VerifyPhotosResToJson(this);
}

@JsonSerializable()
class VerifyPhotosData {
  VerifyPhotosData({this.nextStep, this.intentions});

  factory VerifyPhotosData.fromJson(Map<String, dynamic> json) =>
      _$VerifyPhotosDataFromJson(json);

  final int? nextStep;
  final List<IntentionModel>? intentions;

  Map<String, dynamic> toJson() => _$VerifyPhotosDataToJson(this);
}

@JsonSerializable()
class IntentionModel {
  IntentionModel({this.id, this.label, this.description, this.sortOrder});

  factory IntentionModel.fromJson(Map<String, dynamic> json) =>
      _$IntentionModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  final String? label;
  final String? description;
  final int? sortOrder;

  Map<String, dynamic> toJson() => _$IntentionModelToJson(this);
}
