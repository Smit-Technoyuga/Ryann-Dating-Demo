import 'package:json_annotation/json_annotation.dart';

part 'delete_photos_req_model.g.dart';

DeletePhotosReqModel deserializeDeletePhotosReqModel(
  Map<String, dynamic> json,
) => DeletePhotosReqModel.fromJson(json);

Map<String, dynamic> serializeDeletePhotosReqModel(
  DeletePhotosReqModel model,
) => model.toJson();

@JsonSerializable()
class DeletePhotosReqModel {
  DeletePhotosReqModel({required this.photoUrls});

  factory DeletePhotosReqModel.fromJson(Map<String, dynamic> json) =>
      _$DeletePhotosReqModelFromJson(json);

  @JsonKey(name: 'photoUrls')
  final List<String> photoUrls;

  Map<String, dynamic> toJson() => _$DeletePhotosReqModelToJson(this);
}
