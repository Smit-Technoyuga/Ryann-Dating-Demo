import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_answer_model/compatibility_answer_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_ring_model/compatibility_ring_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/interest_model/interest_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'profile_res_model.g.dart';

ProfileRes deserializeProfileRes(Map<String, dynamic> data) =>
    ProfileRes.fromJson(data);

Map<String, dynamic> serializeProfileRes(ProfileRes data) => data.toJson();

@JsonSerializable()
class ProfileRes extends ApiResponse {
  ProfileRes({this.data, required super.message, required super.success});

  factory ProfileRes.fromJson(Map<String, dynamic> json) =>
      _$ProfileResFromJson(json);

  final ProfileModel? data;

  Map<String, dynamic> toJson() => _$ProfileResToJson(this);
}

@JsonSerializable()
class ProfileModel {
  ProfileModel({
    this.id,
    this.userId,
    this.firstName,
    this.gender,
    this.isPhotoVerified,
    this.ageRangeMin,
    this.matchDistanceKm,
    this.interests,
    this.sharedInterestImportance,
    this.prompts,
    this.promptsData,
    this.compatibilitySkipped,
    this.onboardingStep,
    this.isPremium,
    this.compatibilityAnswers,
    this.compatibilityRing,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dateOfBirth,
    this.profilePicture,
    this.intention,
    this.compatibilityQuestionCount,
    this.compatibilityQuestionAnsweredCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'gender')
  final String? gender;
  @JsonKey(name: 'isPhotoVerified')
  final bool? isPhotoVerified;
  @JsonKey(name: 'ageRangeMin')
  final int? ageRangeMin;
  @JsonKey(name: 'matchDistanceKm')
  final int? matchDistanceKm;
  @JsonKey(name: 'interests')
  final List<InterestModel>? interests;
  @JsonKey(name: 'sharedInterestImportance')
  final String? sharedInterestImportance;
  @JsonKey(name: 'prompts')
  final List<PromptModel>? prompts;
  @JsonKey(name: 'promptsData')
  final List<PromptModel>? promptsData;
  @JsonKey(name: 'compatibilitySkipped')
  final bool? compatibilitySkipped;
  @JsonKey(name: 'onboardingStep')
  final int? onboardingStep;
  @JsonKey(name: 'isPremium')
  final bool? isPremium;
  @JsonKey(name: 'compatibilityAnswers')
  final List<CompatibilityAnswerModel>? compatibilityAnswers;
  @JsonKey(name: 'compatibilityRing')
  final List<CompatibilityRingModel>? compatibilityRing;
  @JsonKey(name: 'compatibilityQuestionAnsweredCount')
  final int? compatibilityQuestionAnsweredCount;
  @JsonKey(name: 'compatibilityQuestionCount')
  final int? compatibilityQuestionCount;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? v;
  @JsonKey(name: 'dateOfBirth')
  final String? dateOfBirth;
  @JsonKey(name: 'profilePicture')
  final List<String>? profilePicture;
  @JsonKey(name: 'intention')
  final List<IntentionModel>? intention;

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
