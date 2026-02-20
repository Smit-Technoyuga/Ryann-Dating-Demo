class Routes {
  static const String initial = '/';
  static const String welcome = '/welcome';
  static const String citySelectionScreen = 'city_selection_screen';
  static const String register = 'register';
  static const String login = 'login';
  static const String forgotPassword = 'forgot_password';
  static const String otp = 'otp';
  static const String resetPassword = 'reset_password';
  static const String tellUsAbout = 'tellUsAbout';
  static const String dob = 'dob';
  static const String membershipScreen = 'membershipScreen';
  static const String photoVerification = 'photoVerification';
  static const String addPhoto = 'addPhoto';
  static const String welcomeIntentionSelection = 'welcomeIntentionSelection';
  static const String intentionSelection = 'intentionSelection';
  static const String intentionConfirmation = 'intentionConfirmation';
  static const String intentionSetSuccess = 'intentionSetSuccess';
  static const String intentionLocked = 'intentionLocked';
  static const String intentionsList = 'intentionsList';
  static const String aboutEachIntention = 'aboutEachIntention';
  static const String profileBasics = 'profileBasics';
  static const String reviewDetails = 'reviewDetails';
  static const String interests = 'interests';
  static const String aboutMe = 'aboutMe';
  static const String compatibilityRing = 'compatibilityRing';
  static const String compatibilityQuestions = 'compatibilityQuestions';
  static const String compatibilityQuestionsList = 'compatibilityQuestionsList';
  static const String prompts = 'prompts';
  static const String customPrompt = 'customPrompt';

  /// Dashboard Routes
  static const String dashboard = '/dashboard';
}

class AppRoutes {
  static const String welcome = Routes.welcome;
  static const String citySelectionScreen =
      '$welcome/${Routes.citySelectionScreen}';
  static const String register = '$citySelectionScreen/${Routes.register}';
  static const String login = '$welcome/${Routes.login}';
  // static const String registerPhone = '$register/${Routes.login}';
  static const String registerPhone = '$citySelectionScreen/${Routes.login}';
  static const String otpScreen = '$login/${Routes.otp}';
  static const String registerPhoneOtp = '$registerPhone/${Routes.otp}';
  static const String tellUsAbout = '$welcome/${Routes.tellUsAbout}';
  static const String dob = '$tellUsAbout/${Routes.dob}';
  static const String membershipScreen = '$welcome/${Routes.membershipScreen}';
  static const String photoVerification =
      '$addPhoto/${Routes.photoVerification}';
  static const String addPhoto = '$welcome/${Routes.addPhoto}';
  static const String welcomeIntentionSelection =
      '$welcome/${Routes.welcomeIntentionSelection}';
  static const String intentionSelection =
      '$welcomeIntentionSelection/${Routes.intentionSelection}';
  static const String intentionConfirmation =
      '$intentionSelection/${Routes.intentionConfirmation}';
  static const String intentionSetSuccess =
      '$welcome/${Routes.intentionSetSuccess}';
  static const String intentionLocked = '$welcome/${Routes.intentionLocked}';
  static const String intentionsList =
      '$intentionLocked/${Routes.intentionsList}';
  static const String aboutEachIntention =
      '$intentionsList/${Routes.aboutEachIntention}';
  static const String profileBasics = '$welcome/${Routes.profileBasics}';
  static const String reviewDetails = '$profileBasics/${Routes.reviewDetails}';
  static const String interests = '$welcome/${Routes.interests}';
  static const String aboutMe = '$interests/${Routes.aboutMe}';
  static const String compatibilityRing =
      '$welcome/${Routes.compatibilityRing}';
  static const String compatibilityQuestions =
      '$compatibilityRing/${Routes.compatibilityQuestions}';
  static const String compatibilityQuestionsList =
      '$compatibilityQuestions/${Routes.compatibilityQuestionsList}';
  static const String prompts = '$welcome/${Routes.prompts}';
  static const String customPrompt = '$prompts/${Routes.customPrompt}';

  /// Dashboard Routes
  static const String dashboard = Routes.dashboard;
}
