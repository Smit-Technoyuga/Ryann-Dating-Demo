// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_res_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileRes _$ProfileResFromJson(Map<String, dynamic> json) => ProfileRes(
  data: json['data'] == null
      ? null
      : ProfileModel.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String,
  success: json['success'] as bool,
);

Map<String, dynamic> _$ProfileResToJson(ProfileRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['_id'] as String?,
  userId: json['userId'] as String?,
  firstName: json['firstName'] as String?,
  gender: json['gender'] as String?,
  isPhotoVerified: json['isPhotoVerified'] as bool?,
  ageRangeMin: (json['ageRangeMin'] as num?)?.toInt(),
  matchDistanceKm: (json['matchDistanceKm'] as num?)?.toInt(),
  interests: (json['interests'] as List<dynamic>?)
      ?.map((e) => InterestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  sharedInterestImportance: json['sharedInterestImportance'] as String?,
  prompts: (json['prompts'] as List<dynamic>?)
      ?.map((e) => PromptModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  promptsData: (json['promptsData'] as List<dynamic>?)
      ?.map((e) => PromptModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  compatibilitySkipped: json['compatibilitySkipped'] as bool?,
  onboardingStep: (json['onboardingStep'] as num?)?.toInt(),
  isPremium: json['isPremium'] as bool?,
  compatibilityAnswers: (json['compatibilityAnswers'] as List<dynamic>?)
      ?.map((e) => CompatibilityAnswerModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  compatibilityRing: (json['compatibilityRing'] as List<dynamic>?)
      ?.map((e) => CompatibilityRingModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
  dateOfBirth: json['dateOfBirth'] as String?,
  profilePicture: (json['profilePicture'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  intention: (json['intention'] as List<dynamic>?)
      ?.map((e) => IntentionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  compatibilityQuestionCount: (json['compatibilityQuestionCount'] as num?)
      ?.toInt(),
  compatibilityQuestionAnsweredCount:
      (json['compatibilityQuestionAnsweredCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'isPhotoVerified': instance.isPhotoVerified,
      'ageRangeMin': instance.ageRangeMin,
      'matchDistanceKm': instance.matchDistanceKm,
      'interests': instance.interests,
      'sharedInterestImportance': instance.sharedInterestImportance,
      'prompts': instance.prompts,
      'promptsData': instance.promptsData,
      'compatibilitySkipped': instance.compatibilitySkipped,
      'onboardingStep': instance.onboardingStep,
      'isPremium': instance.isPremium,
      'compatibilityAnswers': instance.compatibilityAnswers,
      'compatibilityRing': instance.compatibilityRing,
      'compatibilityQuestionAnsweredCount':
          instance.compatibilityQuestionAnsweredCount,
      'compatibilityQuestionCount': instance.compatibilityQuestionCount,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'dateOfBirth': instance.dateOfBirth,
      'profilePicture': instance.profilePicture,
      'intention': instance.intention,
    };
