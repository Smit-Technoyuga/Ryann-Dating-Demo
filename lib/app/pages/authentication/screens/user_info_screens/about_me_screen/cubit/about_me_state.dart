import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AboutMeTone { warm, playful, confident, minimal }

class AboutMeState extends Equatable {
  const AboutMeState({
    this.isAiHelpActive = false,
    this.selectedTone,
    this.suggestions = const [],
    this.isGenerating = false,
    this.isLoading = false,
    this.isSuccess = false,
    required this.aboutMeController,
  });

  final bool isAiHelpActive;
  final AboutMeTone? selectedTone;
  final List<String> suggestions;
  final bool isGenerating;
  final TextEditingController aboutMeController;
  final bool isLoading;
  final bool isSuccess;

  AboutMeState copyWith({
    bool? isAiHelpActive,
    AboutMeTone? selectedTone,
    List<String>? suggestions,
    bool? isGenerating,
    TextEditingController? aboutMeController,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return AboutMeState(
      isAiHelpActive: isAiHelpActive ?? this.isAiHelpActive,
      selectedTone: selectedTone ?? this.selectedTone,
      suggestions: suggestions ?? this.suggestions,
      isGenerating: isGenerating ?? this.isGenerating,
      aboutMeController: aboutMeController ?? this.aboutMeController,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    isAiHelpActive,
    selectedTone,
    suggestions,
    isGenerating,
    isLoading,
    isSuccess,
  ];
}
