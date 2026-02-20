import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_req_model.g.dart';

RefreshTokenReq deserializeRefreshTokenReq(Map<String, dynamic> data) =>
    RefreshTokenReq.fromJson(data);

Map<String, dynamic> serializeRefreshTokenReq(RefreshTokenReq data) =>
    data.toJson();

@JsonSerializable()
class RefreshTokenReq {
  RefreshTokenReq({required this.refreshToken});

  factory RefreshTokenReq.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenReqFromJson(json);

  @JsonKey(name: 'refreshToken')
  final String refreshToken;

  Map<String, dynamic> toJson() => _$RefreshTokenReqToJson(this);
}
