import 'package:json_annotation/json_annotation.dart';
import 'package:ryann_dating/app/data/models/common/common.dart';

part 'verify_otp_res_model.g.dart';

VerifyOtpRes deserializeVerifyOtpRes(Map<String, dynamic> data) =>
    VerifyOtpRes.fromJson(data);

@JsonSerializable()
class VerifyOtpRes extends ApiResponse {
  VerifyOtpRes({this.data, required super.message, required super.success});

  factory VerifyOtpRes.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResFromJson(json);

  final VerifyOtpResModel? data;

  Map<String, dynamic> toJson() => _$VerifyOtpResToJson(this);
}

@JsonSerializable()
class VerifyOtpResModel {
  VerifyOtpResModel({this.accessToken, this.refreshToken, this.user});

  factory VerifyOtpResModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResModelFromJson(json);

  @JsonKey(name: 'accessToken')
  final String? accessToken;
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;
  @JsonKey(name: 'user')
  final UserModel? user;

  Map<String, dynamic> toJson() => _$VerifyOtpResModelToJson(this);
}

@JsonSerializable()
class UserModel {
  UserModel({this.id, this.isOnboardingCompleted, this.isUserInWaitingList});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'isOnboardingCompleted')
  final int? isOnboardingCompleted;
  @JsonKey(name: 'isUserInWaitingList')
  final int? isUserInWaitingList;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
