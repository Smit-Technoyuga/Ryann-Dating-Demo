// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_info_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicInfoReqModel _$BasicInfoReqModelFromJson(Map<String, dynamic> json) =>
    BasicInfoReqModel(
      firstName: json['firstName'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$BasicInfoReqModelToJson(BasicInfoReqModel instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'dateOfBirth': instance.dateOfBirth,
      'gender': instance.gender,
    };
