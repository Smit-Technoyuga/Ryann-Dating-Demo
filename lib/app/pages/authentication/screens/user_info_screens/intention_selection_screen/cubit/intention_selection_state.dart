import 'package:equatable/equatable.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';

class IntentionSelectionState extends Equatable {
  const IntentionSelectionState({
    this.selectedIndex = -1,
    this.tooltipIndex,
    this.intentions = const [],
    this.isLoading = false,
  });

  final int selectedIndex;
  final int? tooltipIndex;
  final List<IntentionModel> intentions;
  final bool isLoading;

  IntentionSelectionState copyWith({
    int? selectedIndex,
    int? tooltipIndex,
    List<IntentionModel>? intentions,
    bool clearTooltip = false,
    bool? isLoading,
  }) {
    return IntentionSelectionState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      tooltipIndex: clearTooltip ? null : (tooltipIndex ?? this.tooltipIndex),
      intentions: intentions ?? this.intentions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    selectedIndex,
    tooltipIndex,
    intentions,
    isLoading,
  ];
}
