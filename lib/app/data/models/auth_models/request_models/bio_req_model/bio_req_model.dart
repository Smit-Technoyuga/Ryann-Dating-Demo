import 'package:json_annotation/json_annotation.dart';

part 'bio_req_model.g.dart';

Map<String, dynamic> serializeBioReqModel(BioReqModel data) => data.toJson();

@JsonSerializable()
class BioReqModel {
  BioReqModel({required this.bio});

  factory BioReqModel.fromJson(Map<String, dynamic> json) =>
      _$BioReqModelFromJson(json);

  @JsonKey(name: 'bio')
  final String bio;

  Map<String, dynamic> toJson() => _$BioReqModelToJson(this);
}
