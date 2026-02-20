// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compatibility_ring_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompatibilityRingModel _$CompatibilityRingModelFromJson(
  Map<String, dynamic> json,
) => CompatibilityRingModel(
  id: json['_id'] as String?,
  label: json['label'] as String?,
  subtitle: json['subtitle'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
);

Map<String, dynamic> _$CompatibilityRingModelToJson(
  CompatibilityRingModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'label': instance.label,
  'subtitle': instance.subtitle,
  'sortOrder': instance.sortOrder,
};
