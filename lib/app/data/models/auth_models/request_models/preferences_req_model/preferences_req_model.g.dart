// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesReqModel _$PreferencesReqModelFromJson(Map<String, dynamic> json) =>
    PreferencesReqModel(
      interestedIn: json['interestedIn'] as String,
      ageRangeMin: (json['ageRangeMin'] as num).toInt(),
      ageRangeMax: (json['ageRangeMax'] as num).toInt(),
      matchDistanceKm: (json['matchDistanceKm'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      occupation: json['occupation'] as String,
      education: json['education'] as String,
      religion: json['religion'] as String,
    );

Map<String, dynamic> _$PreferencesReqModelToJson(
  PreferencesReqModel instance,
) => <String, dynamic>{
  'interestedIn': instance.interestedIn,
  'ageRangeMin': instance.ageRangeMin,
  'ageRangeMax': instance.ageRangeMax,
  'matchDistanceKm': instance.matchDistanceKm,
  'height': instance.height,
  'occupation': instance.occupation,
  'education': instance.education,
  'religion': instance.religion,
};
