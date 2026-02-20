// To parse this JSON data, do
//
//     final waitListRes = waitListResFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'wait_list_res.g.dart';

WaitListRes deserializeWaitListRes(Map<String, dynamic> json) =>
    WaitListRes.fromJson(json);

@JsonSerializable()
class WaitListRes extends ApiResponse {
  WaitListRes({this.data, required super.message, required super.success});

  factory WaitListRes.fromJson(Map<String, dynamic> json) =>
      _$WaitListResFromJson(json);

  final WaitListResModel? data;

  Map<String, dynamic> toJson() => _$WaitListResToJson(this);
}

@JsonSerializable()
class WaitListResModel {
  WaitListResModel({this.allowNext, this.userId});

  factory WaitListResModel.fromJson(Map<String, dynamic> json) =>
      _$WaitListResModelFromJson(json);
  @JsonKey(name: 'allowNext')
  final bool? allowNext;
  @JsonKey(name: 'userId')
  final String? userId;

  Map<String, dynamic> toJson() => _$WaitListResModelToJson(this);
}
