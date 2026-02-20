// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interests_req_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InterestsReqModel _$InterestsReqModelFromJson(Map<String, dynamic> json) =>
    InterestsReqModel(
      interests: (json['interests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sharedInterestImportance: json['sharedInterestImportance'] as String,
    );

Map<String, dynamic> _$InterestsReqModelToJson(InterestsReqModel instance) =>
    <String, dynamic>{
      'interests': instance.interests,
      'sharedInterestImportance': instance.sharedInterestImportance,
    };
