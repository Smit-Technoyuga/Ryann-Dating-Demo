import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';

class JoinWishlistState extends Equatable {
  const JoinWishlistState({
    required this.emailController,
    required this.nameController,
    this.selectedCountry,
    this.isWaitLoad = false,
  });

  final CountryCode? selectedCountry;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final bool isWaitLoad;

  JoinWishlistState copyWith({
    CountryCode? selectedCountry,
    TextEditingController? emailController,
    TextEditingController? nameController,
    bool? isWaitLoad,
  }) {
    return JoinWishlistState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      emailController: emailController ?? this.emailController,
      nameController: nameController ?? this.nameController,
      isWaitLoad: isWaitLoad ?? this.isWaitLoad,
    );
  }

  @override
  List<Object?> get props => [
    selectedCountry,
    emailController,
    nameController,
    isWaitLoad,
  ];
}
