import 'package:equatable/equatable.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/interest_model/interest_model.dart';

enum SharingImportance { important, dontMind, notImportant }

class InterestsState extends Equatable {
  const InterestsState({
    this.selectedInterests = const {},
    this.sharingImportance,
    this.interests = const [],
    this.isLoading = false,
  });

  final Set<String> selectedInterests;
  final SharingImportance? sharingImportance;
  final List<InterestModel> interests;
  final bool isLoading;

  InterestsState copyWith({
    Set<String>? selectedInterests,
    SharingImportance? sharingImportance,
    List<InterestModel>? interests,
    bool? isLoading,
  }) {
    return InterestsState(
      selectedInterests: selectedInterests ?? this.selectedInterests,
      sharingImportance: sharingImportance ?? this.sharingImportance,
      interests: interests ?? this.interests,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    selectedInterests,
    sharingImportance,
    interests,
    isLoading,
  ];
}
