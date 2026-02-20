// To parse this JSON data, do
//
//     final shopAnalytics = shopAnalyticsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'waiting_list_req.g.dart';

Map<String, dynamic> serializeWaitingListReq(WaitingListReq data) =>
    data.toJson();

@JsonSerializable()
class WaitingListReq {
  WaitingListReq({
    this.name,
    this.email,
    this.country,
    this.city,
    this.countryCode,
    this.isoCode,
    this.countryStatus,
    this.cityStatus,
  });

  factory WaitingListReq.fromJson(Map<String, dynamic> json) =>
      _$WaitingListReqFromJson(json);
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @JsonKey(name: 'isoCode')
  final String? isoCode;
  @JsonKey(name: 'countryStatus')
  final String? countryStatus;
  @JsonKey(name: 'cityStatus')
  final String? cityStatus;

  Map<String, dynamic> toJson() => _$WaitingListReqToJson(this);
}
