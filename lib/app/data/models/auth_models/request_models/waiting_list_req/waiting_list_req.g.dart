// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waiting_list_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaitingListReq _$WaitingListReqFromJson(Map<String, dynamic> json) =>
    WaitingListReq(
      name: json['name'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      countryCode: json['countryCode'] as String?,
      isoCode: json['isoCode'] as String?,
      countryStatus: json['countryStatus'] as String?,
      cityStatus: json['cityStatus'] as String?,
    );

Map<String, dynamic> _$WaitingListReqToJson(WaitingListReq instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'country': instance.country,
      'city': instance.city,
      'countryCode': instance.countryCode,
      'isoCode': instance.isoCode,
      'countryStatus': instance.countryStatus,
      'cityStatus': instance.cityStatus,
    };
