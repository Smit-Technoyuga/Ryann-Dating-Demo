import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class IntentionSelectionCubit extends Cubit<IntentionSelectionState> {
  IntentionSelectionCubit({required this.context})
    : super(const IntentionSelectionState());
  final BuildContext context;

  void selectIntention(int index) {
    emit(state.copyWith(selectedIndex: index, clearTooltip: true));
  }

  void toggleTooltip(int index) {
    if (state.tooltipIndex == index) {
      emit(state.copyWith(clearTooltip: true));
    } else {
      emit(state.copyWith(tooltipIndex: index));
    }
  }

  void hideTooltip() {
    if (state.tooltipIndex != null) {
      emit(state.copyWith(clearTooltip: true));
    }
  }

  void setIntentions(List<IntentionModel> intentions) {
    emit(state.copyWith(intentions: intentions));
  }

  Future<void> setIntention() async {
    emit(state.copyWith(isLoading: true));
    final item = state.intentions[state.selectedIndex];
    try {
      await getIt<AuthServices>()
          .setIntention({'intention': item.label})
          .handler(
            showToast: true,
            isLoading: false,
            onSuccess: (value) {
              emit(state.copyWith(isLoading: false));
              context.go(
                AppRoutes.intentionSetSuccess,
                extra: state.intentions,
              );
            },
            onFailed: (error) {
              emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}

class IntentionItem {
  IntentionItem({required this.title, required this.description});
  final String title;
  final String description;
}
