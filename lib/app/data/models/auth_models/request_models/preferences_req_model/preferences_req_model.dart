import 'package:json_annotation/json_annotation.dart';

part 'preferences_req_model.g.dart';

Map<String, dynamic> serializePreferencesReqModel(PreferencesReqModel data) =>
    data.toJson();
    

@JsonSerializable()
class PreferencesReqModel {
  PreferencesReqModel({
    required this.interestedIn,
    required this.ageRangeMin,
    required this.ageRangeMax,
    required this.matchDistanceKm,
    required this.height,
    required this.occupation,
    required this.education,
    required this.religion,
  });

  factory PreferencesReqModel.fromJson(Map<String, dynamic> json) =>
      _$PreferencesReqModelFromJson(json);

  @JsonKey(name: 'interestedIn')
  final String interestedIn;
  @JsonKey(name: 'ageRangeMin')
  final int ageRangeMin;
  @JsonKey(name: 'ageRangeMax')
  final int ageRangeMax;
  @JsonKey(name: 'matchDistanceKm')
  final int matchDistanceKm;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'occupation')
  final String occupation;
  @JsonKey(name: 'education')
  final String education;
  @JsonKey(name: 'religion')
  final String religion;

  Map<String, dynamic> toJson() => _$PreferencesReqModelToJson(this);
}
