import 'package:equatable/equatable.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_answer_model/compatibility_answer_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/question_model/question_model.dart';

class CompatibilityQuestion {
  const CompatibilityQuestion({
    required this.title,
    required this.icon,
    required this.question,
    required this.options,
    this.isMulti = false,
  });
  final String title;
  final String icon;
  final String question;
  final bool isMulti;
  final List<String> options;
}

class CompatibilityQuestionsState extends Equatable {
  const CompatibilityQuestionsState({
    this.currentStep = 0,
    this.questions = const [],
    this.answers = const {},
    this.isLoading = false,
    this.initialAnswers = const [],
  });
  final int currentStep;
  final List<Question> questions;
  final Map<int, String?> answers;
  final bool isLoading;
  final List<CompatibilityAnswerModel> initialAnswers;

  CompatibilityQuestionsState copyWith({
    int? currentStep,
    List<Question>? questions,
    Map<int, String?>? answers,
    bool? isLoading,
    List<CompatibilityAnswerModel>? initialAnswers,
  }) {
    return CompatibilityQuestionsState(
      currentStep: currentStep ?? this.currentStep,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
      initialAnswers: initialAnswers ?? this.initialAnswers,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    questions,
    answers,
    isLoading,
    initialAnswers,
  ];
}
