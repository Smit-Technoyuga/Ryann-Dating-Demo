import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'country_city_model.g.dart';

CountryCityModel deserializeCountryCityModel(Map<String, dynamic> json) =>
    CountryCityModel.fromJson(json);

Map<String, dynamic> serializeCountryCityModel(CountryCityModel model) =>
    model.toJson();

@JsonSerializable()
class CountryCityModel extends ApiResponse {
  CountryCityModel({this.data, required super.message, required super.success});

  factory CountryCityModel.fromJson(Map<String, dynamic> json) =>
      _$CountryCityModelFromJson(json);

  final List<Country>? data;

  Map<String, dynamic> toJson() => _$CountryCityModelToJson(this);
}

@JsonSerializable()
class Country {
  Country({
    required this.name,
    this.cities,
    this.isInternational = true,
    this.launchStatus,
    this.id,
    this.isoCode,
    this.priority,
    this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? isoCode;
  final int? priority;
  final List<Country>? cities;
  final bool? isInternational;
  final CityStatus? launchStatus;
  final String? countryCode;

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  Country copyWith({
    String? id,
    String? name,
    String? isoCode,
    int? priority,
    List<Country>? cities,
    bool? isInternational,
    CityStatus? launchStatus,
    String? countryCode,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      isoCode: isoCode ?? this.isoCode,
      priority: priority ?? this.priority,
      cities: cities ?? this.cities,
      isInternational: isInternational ?? this.isInternational,
      launchStatus: launchStatus ?? this.launchStatus,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}

enum CityStatus { LIVE, launchingNext, WAITLIST }
