import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_cubit.dart';

class BasicInfoState extends Equatable {
  const BasicInfoState({
    required this.nameController,
    required this.dobControllers,
    required this.dobFocusNodes,
    this.gender,
    this.dobText = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  final TextEditingController nameController;
  final List<TextEditingController> dobControllers;
  final List<FocusNode> dobFocusNodes;
  final Gender? gender;
  final bool isLoading;
  final bool isSuccess;

  final String dobText;

  BasicInfoState copyWith({
    TextEditingController? nameController,
    List<TextEditingController>? dobControllers,
    List<FocusNode>? dobFocusNodes,
    Gender? gender,
    bool? isLoading,
    bool? isSuccess,
    String dobText = '',
  }) {
    return BasicInfoState(
      nameController: nameController ?? this.nameController,
      dobControllers: dobControllers ?? this.dobControllers,
      dobFocusNodes: dobFocusNodes ?? this.dobFocusNodes,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      dobText: dobText,
    );
  }

  @override
  List<Object?> get props => [
    nameController,
    dobControllers,
    dobFocusNodes,
    gender,
    isLoading,
    isSuccess,
    dobText,
  ];
}
