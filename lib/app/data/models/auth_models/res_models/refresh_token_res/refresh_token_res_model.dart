import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'refresh_token_res_model.g.dart';

RefreshTokenRes deserializeRefreshTokenRes(Map<String, dynamic> data) =>
    RefreshTokenRes.fromJson(data);

Map<String, dynamic> serializeRefreshTokenRes(RefreshTokenRes data) =>
    data.toJson();

@JsonSerializable()
class RefreshTokenRes extends ApiResponse {
  RefreshTokenRes({this.data, required super.message, required super.success});

  factory RefreshTokenRes.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResFromJson(json);

  @JsonKey(name: 'data')
  final RefreshTokenData? data;

  Map<String, dynamic> toJson() => _$RefreshTokenResToJson(this);
}

@JsonSerializable()
class RefreshTokenData {
  RefreshTokenData({this.accessToken, this.refreshToken});

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);

  @JsonKey(name: 'accessToken')
  final String? accessToken;
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenDataToJson(this);
}
