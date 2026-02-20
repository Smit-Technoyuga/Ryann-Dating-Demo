import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/bio_req_model/bio_req_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/about_me_screen/cubit/about_me_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class AboutMeCubit extends Cubit<AboutMeState> {
  AboutMeCubit()
    : super(AboutMeState(aboutMeController: TextEditingController()));

  void toggleAiHelp() {
    emit(state.copyWith(isAiHelpActive: !state.isAiHelpActive));
  }

  void selectTone(AboutMeTone tone) {
    emit(
      state.copyWith(selectedTone: tone, isGenerating: true, suggestions: []),
    );

    // Mock AI generation
    Future.delayed(const Duration(seconds: 1), () {
      var mockSuggestions = <String>[];
      switch (tone) {
        case AboutMeTone.warm:
          mockSuggestions = [
            "I'm a warm-hearted person who loves long walks and good coffee. Looking for someone to share life's simple joys with.",
            'Always trying to see the best in people. I love nature, cooking, and deep conversations.',
          ];
        case AboutMeTone.playful:
          mockSuggestions = [
            "Pro at parallel parking and making questionable life choices. Let's go on an adventure!",
            "I'm 50% coffee, 50% puns, and 100% ready to meet you. If you can handle my bad jokes, we'll get along.",
          ];
        case AboutMeTone.confident:
          mockSuggestions = [
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
            "I know what I want and I'm not afraid to go after it. Looking for someone who can keep up with my ambition.",
          ];
        case AboutMeTone.minimal:
          mockSuggestions = [
            'Just a simple guy looking for a genuine connection.',
            'Passionate about travel and good food. Less is more.',
          ];
      }
      emit(state.copyWith(suggestions: mockSuggestions, isGenerating: false));
    });
  }

  // ignore: use_setters_to_change_properties
  void useSuggestion(String value) {
    state.aboutMeController.text = value;
  }

  Future<void> saveBio(BuildContext context) async {
    if (state.aboutMeController.text.isEmpty) {
      context.l10n.writeSomethingShort.errorToast;
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final req = BioReqModel(bio: state.aboutMeController.text);

      await getIt<AuthServices>()
          .updateBio(req)
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              emit(state.copyWith(isLoading: false, isSuccess: true));
              context.push(AppRoutes.prompts, extra: value.data?.prompts);
            },
            onFailed: (value) {
              emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
