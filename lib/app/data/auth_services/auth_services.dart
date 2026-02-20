import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/basic_info_req_model/basic_info_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/bio_req_model/bio_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/delete_photos_req/delete_photos_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/interests_req_model/interests_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/preferences_req_model/preferences_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/prompts_req_model/prompts_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/refresh_token_req_model/refresh_token_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/send_otp_model/send_otp_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/submit_compatibility_req_model/submit_compatibility_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/verify_otp_req_model/verify_otp_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/waiting_list_req/waiting_list_req.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/basic_info_res/basic_info_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/country_city_model/country_city_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/profile_res/profile_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/question_model/question_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/refresh_token_res/refresh_token_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/send_otp_res/send_otp_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_otp_res/verify_otp_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/waitlist_res/wait_list_res.dart';
import 'package:ryann_dating/app/utils/config/app_config.dart';

part 'auth_services.g.dart';

@RestApi(parser: Parser.FlutterCompute, baseUrl: AppConfig.baseUrl)
@lazySingleton
abstract class AuthServices {
  @factoryMethod
  factory AuthServices(Dio dio) => _AuthServices(dio);

  @POST(AppConfig.checkWaitingListApi)
  Future<WaitListRes> checkWaitingList(
    @Body() WaitingListReq body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.sendOtpApi)
  Future<SendOtpRes> sendOtp(
    @Body() SendOtpModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.verifyOtpApi)
  Future<VerifyOtpRes> verifyOtp(
    @Body() VerifyOtpReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.registerApi)
  Future<void> register(
    @Body() Map<String, dynamic> body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.loginApi)
  Future<void> login(
    @Body() Map<String, dynamic> body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.logoutApi)
  Future<void> logout(
    @Body() Map<String, dynamic> body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(AppConfig.questionsApi)
  Future<QuestionModel> getQuestions({
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.updateProfileApi)
  Future<void> updateProfile(
    @Body() Map<String, dynamic> body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(AppConfig.getCountriesApi)
  Future<CountryCityModel> getCountries({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET(AppConfig.profileApi)
  Future<ProfileRes> getProfile({@CancelRequest() CancelToken? cancelToken});

  @POST(AppConfig.refreshTokenApi)
  Future<RefreshTokenRes> refreshToken(
    @Body() RefreshTokenReq body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.basicInfoApi)
  Future<BasicInfoRes> saveBasicInfo(
    @Body() BasicInfoReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.takeMembershipApi)
  Future<BasicInfoRes> takeMembership({
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.addPhotosApi)
  @MultiPart()
  Future<BasicInfoRes> addPhotos(
    @Part(name: 'photos') List<MultipartFile> photos,
    @SendProgress() ProgressCallback? onSendProgress, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.verifyPhotosApi)
  Future<VerifyPhotosRes> verifyPhotos({
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.setIntentionApi)
  Future<BasicInfoRes> setIntention(
    @Body() Map<String, dynamic> body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.preferencesApi)
  Future<BasicInfoRes> updatePreferences(
    @Body() PreferencesReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.userInterestsApi)
  Future<BasicInfoRes> updateInterests(
    @Body() InterestsReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.userBioApi)
  Future<BasicInfoRes> updateBio(
    @Body() BioReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.userPromptsApi)
  Future<BasicInfoRes> updatePrompts(
    @Body() PromptsReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.submitCompatibilityApi)
  Future<BasicInfoRes> submitCompatibility(
    @Body() SubmitCompatibilityReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(AppConfig.deletePhotosApi)
  Future<BasicInfoRes> deletePhotos(
    @Body() DeletePhotosReqModel body, {
    @CancelRequest() CancelToken? cancelToken,
  });
}
