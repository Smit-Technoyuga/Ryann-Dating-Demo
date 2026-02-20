import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum InterestedIn { men, women, everyone }

class ProfileBasicsState extends Equatable {
  const ProfileBasicsState({
    required this.locationController,
    this.interestedIn,
    this.ageRange = const RangeValues(18, 100),
    this.matchDistance = 22,
    this.height,
    this.occupation,
    this.education,
    this.religion,
    this.isLoading = false,
    this.isSuccess = false,
  });

  final InterestedIn? interestedIn;
  final TextEditingController locationController;
  final RangeValues ageRange;
  final double matchDistance;
  final String? height;
  final String? occupation;
  final String? education;
  final String? religion;
  final bool isLoading;
  final bool isSuccess;

  ProfileBasicsState copyWith({
    InterestedIn? interestedIn,
    RangeValues? ageRange,
    double? matchDistance,
    String? height,
    String? occupation,
    String? education,
    String? religion,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ProfileBasicsState(
      locationController: locationController,
      interestedIn: interestedIn ?? this.interestedIn,
      ageRange: ageRange ?? this.ageRange,
      matchDistance: matchDistance ?? this.matchDistance,
      height: height ?? this.height,
      occupation: occupation ?? this.occupation,
      education: education ?? this.education,
      religion: religion ?? this.religion,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    interestedIn,
    locationController,
    ageRange,
    matchDistance,
    height,
    occupation,
    education,
    religion,
    isLoading,
    isSuccess,
  ];
}
