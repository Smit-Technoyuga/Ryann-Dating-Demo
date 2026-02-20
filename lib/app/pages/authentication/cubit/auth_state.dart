import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/country_city_model/country_city_model.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.countries,
    this.defaultCountry,
    this.selectedCountry,
    this.selectedCity,
    required this.countryController,
    required this.cityController,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.otpController,
    required this.searchController,
    this.phoneCountry,
    this.isRegister = false,
    required this.focusNode,
    this.isLoading = false,
    this.isWaitLoad = false,
    this.isSendOtpLoad = false,
    this.isVerifyOtpLoad = false,
    this.isReSendOtpLoad = false,
    this.userId,
    this.searchQuery = '',
  });

  final List<Country> countries;
  final Country? defaultCountry;
  final Country? selectedCountry;
  final CountryCode? phoneCountry;
  final Country? selectedCity;
  final TextEditingController countryController;
  final TextEditingController otpController;
  final TextEditingController cityController;
  final TextEditingController searchController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final FocusNode focusNode;
  final bool isRegister;
  final bool isLoading;
  final bool isWaitLoad;
  final bool isSendOtpLoad;
  final bool isReSendOtpLoad;
  final bool isVerifyOtpLoad;
  final String? userId;
  final String searchQuery;

  AuthState copyWith({
    List<Country>? countries,
    Country? defaultCountry,
    CountryCode? phoneCountry,
    Country? selectedCountry,
    Country? selectedCity,
    bool clearSelectedCity = false,
    TextEditingController? countryController,
    TextEditingController? cityController,
    TextEditingController? searchController,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? otpController,
    FocusNode? focusNode,
    bool? isRegister,
    bool? isLoading,
    bool? isWaitLoad,
    bool? isSendOtpLoad,
    bool? isVerifyOtpLoad,
    bool? isReSendOtpLoad,
    String? userId,
    String? searchQuery,
  }) {
    return AuthState(
      countries: countries ?? this.countries,
      isWaitLoad: isWaitLoad ?? this.isWaitLoad,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      defaultCountry: defaultCountry ?? this.defaultCountry,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isRegister: isRegister ?? this.isRegister,
      otpController: otpController ?? this.otpController,
      searchController: searchController ?? this.searchController,
      selectedCity: clearSelectedCity
          ? null
          : (selectedCity ?? this.selectedCity),
      cityController: cityController ?? this.cityController,
      countryController: countryController ?? this.countryController,
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      focusNode: focusNode ?? this.focusNode,
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
      isSendOtpLoad: isSendOtpLoad ?? this.isSendOtpLoad,
      isVerifyOtpLoad: isVerifyOtpLoad ?? this.isVerifyOtpLoad,
      isReSendOtpLoad: isReSendOtpLoad ?? this.isReSendOtpLoad,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    countries,
    defaultCountry,
    selectedCountry,
    selectedCity,
    cityController,
    countryController,
    nameController,
    emailController,
    phoneController,
    otpController,
    searchController,
    phoneCountry,
    focusNode,
    isRegister,
    isLoading,
    isWaitLoad,
    userId,
    isSendOtpLoad,
    isVerifyOtpLoad,
    isReSendOtpLoad,
    searchQuery,
  ];
}

class OtpTimerState extends Equatable {
  const OtpTimerState({required this.time});

  final int time;

  OtpTimerState copyWith({required int time}) {
    return OtpTimerState(time: time);
  }

  @override
  List<Object?> get props => [time];
}

class LoginState extends Equatable {
  const LoginState({required this.isTap});

  final bool isTap;

  LoginState copyWith({required bool isTap}) {
    return LoginState(isTap: isTap);
  }

  @override
  List<Object?> get props => [isTap];
}
