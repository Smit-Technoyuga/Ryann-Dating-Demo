import 'package:equatable/equatable.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/profile_res/profile_res_model.dart';

class ProfileState extends Equatable {
  const ProfileState({this.profile, this.isLoading = false, this.error});

  final ProfileModel? profile;
  final bool isLoading;
  final String? error;

  @override
  List<Object?> get props => [profile, isLoading, error];

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
