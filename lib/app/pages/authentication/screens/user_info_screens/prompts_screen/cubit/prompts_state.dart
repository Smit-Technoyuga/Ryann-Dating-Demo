import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';

class PromptsState extends Equatable {
  const PromptsState({
    this.prompts = const [],
    this.selectedPrompts = const {},
    this.isLoading = false,
    this.isSuccess = false,
  });

  final List<PromptModel> prompts;
  final Map<String, TextEditingController> selectedPrompts;
  final bool isLoading;
  final bool isSuccess;

  PromptsState copyWith({
    List<PromptModel>? prompts,
    Map<String, TextEditingController>? selectedPrompts,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return PromptsState(
      prompts: prompts ?? this.prompts,
      selectedPrompts: selectedPrompts ?? this.selectedPrompts,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [prompts, selectedPrompts, isLoading, isSuccess];
}
