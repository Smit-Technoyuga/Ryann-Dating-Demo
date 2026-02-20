// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCityModel _$CountryCityModelFromJson(Map<String, dynamic> json) =>
    CountryCityModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$CountryCityModelToJson(CountryCityModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  name: json['name'] as String,
  cities: (json['cities'] as List<dynamic>?)
      ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
      .toList(),
  isInternational: json['isInternational'] as bool? ?? true,
  launchStatus: $enumDecodeNullable(_$CityStatusEnumMap, json['launchStatus']),
  id: json['_id'] as String?,
  isoCode: json['isoCode'] as String?,
  priority: (json['priority'] as num?)?.toInt(),
  countryCode: json['countryCode'] as String?,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'isoCode': instance.isoCode,
  'priority': instance.priority,
  'cities': instance.cities,
  'isInternational': instance.isInternational,
  'launchStatus': _$CityStatusEnumMap[instance.launchStatus],
  'countryCode': instance.countryCode,
};

const _$CityStatusEnumMap = {
  CityStatus.LIVE: 'LIVE',
  CityStatus.launchingNext: 'launchingNext',
  CityStatus.WAITLIST: 'WAITLIST',
};
