import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/submit_compatibility_req_model/submit_compatibility_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_answer_model/compatibility_answer_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/cubit/compatibility_questions_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class CompatibilityQuestionsCubit extends Cubit<CompatibilityQuestionsState> {
  CompatibilityQuestionsCubit({
    int? answeredCount,
    List<CompatibilityAnswerModel>? initialAnswers,
  }) : super(
         CompatibilityQuestionsState(
           currentStep: answeredCount ?? 0,
           initialAnswers: initialAnswers ?? const [],
         ),
       );

  void selectOption(String option) {
    final answers = Map<int, String?>.from(state.answers);
    answers[state.currentStep] = option;
    emit(state.copyWith(answers: answers));
  }

  void selectMultipleOptions(String option) {
    final answers = Map<int, String?>.from(state.answers);
    final currentAnswer = answers[state.currentStep] ?? '';
    final selectedOptions = currentAnswer
        .split(', ')
        .where((e) => e.isNotEmpty)
        .toList();
    final isPrefer = option == 'prefer_not';
    if (isPrefer) {
      selectedOptions.clear();
      selectedOptions.add(option);
    } else {
      if (selectedOptions.length < 3 && !is3AnswerSelected()) {
        if (selectedOptions.contains(option)) {
          selectedOptions.remove(option);
        } else {
          selectedOptions.add(option);
        }
      } else if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else if (selectedOptions.contains('prefer_not')) {
        selectedOptions.clear();
        selectedOptions.add(option);
      }
    }
    answers[state.currentStep] = selectedOptions.join(', ');
    emit(state.copyWith(answers: answers));
  }

  bool is3AnswerSelected() {
    final answers = Map<int, String?>.from(state.answers);
    final currentAnswer = answers[state.currentStep] ?? '';
    final selectedOptions = currentAnswer
        .split(', ')
        .where((e) => e.isNotEmpty)
        .toList();
    return selectedOptions.length >= 3 ||
        selectedOptions.contains('prefer_not');
  }

  void nextStep(BuildContext context, VoidCallback onComplete) {
    if (state.currentStep < state.questions.length - 1) {
      final currentQue = state.questions[state.currentStep];
      final nextQue = state.questions[state.currentStep + 1];

      if (currentQue.category != nextQue.category) {
        submitCompatibilityAnswers(context);
      } else {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    } else {
      submitCompatibilityAnswers(context, isNext: false);
      onComplete();
    }
  }

  void saveAndExit(BuildContext context, VoidCallback onSave) {
    submitCompatibilityAnswers(context, onSuccess: onSave, isSaveAndExit: true);
  }

  Future<void> submitCompatibilityAnswers(
    BuildContext context, {
    VoidCallback? onSuccess,
    bool isNext = true,
    bool isSaveAndExit = false,
  }) async {
    final questionAnswers = <CompatibilityAnswerRequest>[];

    state.answers.forEach((index, value) {
      if (value != null && index < state.questions.length) {
        final question = state.questions[index];
        questionAnswers.add(
          CompatibilityAnswerRequest(
            questionKey: question.questionKey ?? '',
            answers: value.split(', ').where((e) => e.isNotEmpty).toList(),
          ),
        );
      }
    });

    final body = SubmitCompatibilityReqModel(questionAnswers: questionAnswers);

    await getIt<AuthServices>()
        .submitCompatibility(body)
        .handler(
          onSuccess: (value) {
            onSuccess?.call();
            if (isNext) {
              if (!isSaveAndExit) {
                emit(state.copyWith(currentStep: state.currentStep + 1));
              }
            } else {
              context.go(AppRoutes.dashboard);
            }
          },
        );
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> getQuestions() async {
    emit(state.copyWith(isLoading: true));
    await getIt<AuthServices>().getQuestions().handler(
      isLoading: false,
      onSuccess: (value) {
        if (value.success) {
          final questions = value.data?.questions ?? [];
          final answers = Map<int, String?>.from(state.answers);

          // Pre-fill answers from initialAnswers
          for (var i = 0; i < questions.length; i++) {
            final qKey = questions[i].questionKey;
            final initial = state.initialAnswers.firstWhere(
              (element) => element.questionKey == qKey,
              orElse: CompatibilityAnswerModel.new,
            );
            if (initial.answers != null && initial.answers!.isNotEmpty) {
              answers[i] = initial.answers!.join(', ');
            }
          }

          emit(
            state.copyWith(
              isLoading: false,
              questions: questions,
              answers: answers,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
        }
      },
      onFailed: (value) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  // void initializeQuestions(BuildContext context) {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     final questions = [
  //       CompatibilityQuestion(
  //         title: context.l10n.familyPlans,
  //         icon: '👶',
  //         question: context.l10n.doYouHaveOrWantKids,
  //         options: [
  //           context.l10n.iWantKids,
  //           context.l10n.iDontWantKids,
  //           context.l10n.imUnsure,
  //           context.l10n.iAlreadyHaveKids,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.familyPlans,
  //         icon: '👶',
  //         question: context.l10n.whenAreYouHopingToHaveKids,
  //         options: [
  //           context.l10n.asSoonAsPossible,
  //           context.l10n.inNext1To2Years,
  //           context.l10n.inNext3To5Years,
  //           context.l10n.someday,
  //           context.l10n.notAnytimeSoon,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.familyPlans,
  //         icon: '👶',
  //         question: context.l10n.howManyKidsIdeally,
  //         options: ['1', '2', '3', '4+', context.l10n.kidsUndecided],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.familyPlans,
  //         icon: '👶',
  //         question: context.l10n.whenAreYouHopingToHaveKids,
  //         options: [
  //           context.l10n.yes,
  //           context.l10n.maybe,
  //           context.l10n.no,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.familyPlans,
  //         icon: '👶',
  //         question: context.l10n.datePeopleWithKids,
  //         options: [
  //           context.l10n.yes,
  //           context.l10n.no,
  //           context.l10n.onlyDateSingleParents,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.whatsYourRelationshipWithFitness,
  //         options: [
  //           context.l10n.fitnessBigPartOfLife,
  //           context.l10n.iWorkOutRegularly,
  //           context.l10n.iWorkOutOccasionally,
  //           context.l10n.notIntoFitness,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.preferPartnerSimilarFitness,
  //         options: [
  //           context.l10n.yes,
  //           context.l10n.itsNiceBonus,
  //           context.l10n.no,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.weekdayWakeUpTime,
  //         options: [
  //           context.l10n.before6am,
  //           context.l10n.between6And7am,
  //           context.l10n.between7And8am,
  //           context.l10n.after8am,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.sleepPatternImportance,
  //         options: [
  //           context.l10n.veryImportant,
  //           context.l10n.somewhatImportant,
  //           context.l10n.notImportant,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.drinkAlcohol,
  //         options: [
  //           context.l10n.yes,
  //           context.l10n.drinkOccasionally,
  //           context.l10n.no,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.smoke,
  //         options: [
  //           context.l10n.yes,
  //           context.l10n.drinkOccasionally,
  //           context.l10n.no,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.lifestyleAndHabits,
  //         icon: '🧘',
  //         question: context.l10n.smokingDealBreaker,
  //         options: [
  //           context.l10n.dealBreaker,
  //           context.l10n.preferTheyDont,
  //           context.l10n.dontMind,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.socialEnergy,
  //         icon: '🤝',
  //         question: context.l10n.socialEnergyDesc,
  //         options: [
  //           context.l10n.introvert,
  //           context.l10n.extrovert,
  //           context.l10n.ambivert,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.socialEnergy,
  //         icon: '🤝',
  //         question: context.l10n.socialEnergyImportance,
  //         options: [
  //           context.l10n.veryImportant,
  //           context.l10n.somewhatImportant,
  //           context.l10n.notImportant,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.socialEnergy,
  //         icon: '🤝',
  //         question: context.l10n.idealWeekendVibe,
  //         options: [
  //           context.l10n.outWithFriends,
  //           context.l10n.quietAtHome,
  //           context.l10n.mixOfBoth,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.communicationStyle,
  //         icon: '💬',
  //         question: context.l10n.communicationFrequency,
  //         options: [
  //           context.l10n.multipleTimesADay,
  //           context.l10n.onceADay,
  //           context.l10n.everyFewDays,
  //           context.l10n.noSetPreference,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.communicationStyle,
  //         icon: '💬',
  //         question: context.l10n.lateReplyFeeling,
  //         options: [
  //           context.l10n.itUpsetsMe,
  //           context.l10n.iGetInMyHead,
  //           context.l10n.noticeButFine,
  //           context.l10n.doesntBotherMe,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.communicationStyle,
  //         icon: '💬',
  //         question: context.l10n.communicationProblems,
  //         options: [
  //           context.l10n.often,
  //           context.l10n.sometimes,
  //           context.l10n.rarely,
  //           context.l10n.no,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.conflictStyle,
  //         icon: '⚖️',
  //         question: context.l10n.handleDisagreements,
  //         options: [
  //           context.l10n.talkImmediately,
  //           context.l10n.takeTimeToProcess,
  //           context.l10n.walkAway,
  //           context.l10n.shutDown,
  //           context.l10n.becomeReactive,
  //           context.l10n.useHumour,
  //           context.l10n.stayCalm,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.intimacyExpectations,
  //         icon: '❤️',
  //         question: context.l10n.intimacyDefinition,
  //         options: [
  //           context.l10n.physicalCloseness,
  //           context.l10n.emotionalFirst,
  //           context.l10n.balanceBoth,
  //           context.l10n.gradualIntimacy,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.intimacyExpectations,
  //         icon: '❤️',
  //         question: context.l10n.physicalAffectionImportance,
  //         options: [
  //           context.l10n.veryImportant,
  //           context.l10n.somewhatImportant,
  //           context.l10n.notImportant,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.intimacyExpectations,
  //         icon: '❤️',
  //         question: context.l10n.pdaComfort,
  //         options: [
  //           context.l10n.veryComfortable,
  //           context.l10n.somewhatComfortable,
  //           context.l10n.neutral,
  //           context.l10n.uncomfortable,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.intimacyExpectations,
  //         icon: '❤️',
  //         question: context.l10n.reassuranceResponse,
  //         options: [
  //           context.l10n.comfortableResponsive,
  //           context.l10n.comfortableNeedSpace,
  //           context.l10n.feelTense,
  //           context.l10n.feelOverwhelmed,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.intimacyExpectations,
  //         icon: '❤️',
  //         question: context.l10n.intimacyMismatchTension,
  //         options: [
  //           context.l10n.dealBreakerTension,
  //           context.l10n.ongoingFriction,
  //           context.l10n.littleTension,
  //           context.l10n.noTension,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.valuesAndPriorities,
  //         icon: '🌟',
  //         question: context.l10n.chooseUpToThreeValues,
  //         isMulti: true,
  //         options: [
  //           context.l10n.careerAndSuccess,
  //           context.l10n.familyAndChildren,
  //           context.l10n.stability,
  //           context.l10n.travelAndExperiences,
  //           context.l10n.healthAndFitness,
  //           context.l10n.financialGoals,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //       CompatibilityQuestion(
  //         title: context.l10n.valuesAndPriorities,
  //         icon: '🌟',
  //         question: context.l10n.selectUpToThreeDealBreakers,
  //         isMulti: true,
  //         options: [
  //           context.l10n.lackOfAmbition,
  //           context.l10n.poorCommunication,
  //           context.l10n.emotionalImmaturity,
  //           context.l10n.smoking,
  //           context.l10n.heavyDrinking,
  //           context.l10n.jealousyIssues,
  //           context.l10n.differentFamilyGoals,
  //           context.l10n.preferNotToSay,
  //         ],
  //       ),
  //     ];
  //     emit(state.copyWith(questions: questions));
  //   });
  // }
}
