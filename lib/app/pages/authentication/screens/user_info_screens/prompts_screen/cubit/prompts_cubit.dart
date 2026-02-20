import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/prompts_req_model/prompts_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_ring_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class PromptsCubit extends Cubit<PromptsState> {
  PromptsCubit(List<PromptModel> prompts)
    : super(PromptsState(prompts: prompts));

  void togglePrompt(PromptModel prompt) {
    final selected = Map<String, TextEditingController>.from(
      state.selectedPrompts,
    );
    final question = prompt.question ?? '';

    if (selected.containsKey(question)) {
      selected.remove(question);
    } else {
      if (selected.length < 2) {
        selected[question] = TextEditingController();
      }
    }
    emit(state.copyWith(selectedPrompts: selected));
  }

  void addCustomPrompt(String question, BuildContext context) {
    if (question.isEmpty) return;

    final selected = Map<String, TextEditingController>.from({});
    selected['custom'] = TextEditingController(text: question);
    emit(state.copyWith(selectedPrompts: selected));
    submit(context);
  }

  Future<void> submit(BuildContext context) async {
    final data = <Map<String, dynamic>>[];
    for (final entry in state.selectedPrompts.entries) {
      data.add({'prompt': entry.key, 'response': entry.value.text});
    }

    if (data.isEmpty) {
      'Please select at least one prompt'.errorToast;
      return;
    }
    if (data.any((e) => e['response']?.toString().isEmpty ?? true)) {
      'Please fill all selected prompts'.errorToast;
      return;
    }
    if (data.any((e) => (e['response']?.toString().length ?? 0) <= 5)) {
      'Please fill all selected prompts with at least 5 characters'.errorToast;
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final req = PromptsReqModel(prompts: data);
      await getIt<AuthServices>()
          .updatePrompts(req)
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              emit(state.copyWith(isLoading: false, isSuccess: true));
              context.go(
                AppRoutes.compatibilityRing,
                extra: CompatibilityRingScreenArgs(
                  compatibilityRing: value.data?.compatibilityRing,
                ),
              );
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
