import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @welcomeTheGood.
  ///
  /// In en, this message translates to:
  /// **'Where the good ones go'**
  String get welcomeTheGood;

  /// No description provided for @byTappingCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'By tapping ‘Create Account’ or ‘Sign In,’ you agree to our Terms. Learn how we process your data in our Privacy & Cookies Policy.'**
  String get byTappingCreateAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @troubleInSigningIn.
  ///
  /// In en, this message translates to:
  /// **'Trouble signing in?'**
  String get troubleInSigningIn;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @continues.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continues;

  /// No description provided for @whereAreYouBased.
  ///
  /// In en, this message translates to:
  /// **'Where Are You Based?'**
  String get whereAreYouBased;

  /// No description provided for @launchingCityByCity.
  ///
  /// In en, this message translates to:
  /// **'We’re launching city by city'**
  String get launchingCityByCity;

  /// No description provided for @nowLive.
  ///
  /// In en, this message translates to:
  /// **'Now Live'**
  String get nowLive;

  /// No description provided for @joinWaitlist.
  ///
  /// In en, this message translates to:
  /// **'Join Waitlist'**
  String get joinWaitlist;

  /// No description provided for @launchingNext.
  ///
  /// In en, this message translates to:
  /// **'Launching Next'**
  String get launchingNext;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @registerYourInterest.
  ///
  /// In en, this message translates to:
  /// **'Register your interest'**
  String get registerYourInterest;

  /// No description provided for @notLiveInAreaMessage.
  ///
  /// In en, this message translates to:
  /// **'We’re not live in your area yet — add your details and we’ll let you know when Ryann launches near you.'**
  String get notLiveInAreaMessage;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get selectCountry;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @enterYourCity.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enterYourCity;

  /// No description provided for @enterYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Enter your coutry'**
  String get enterYourCountry;

  /// No description provided for @pleaseSelectYourCity.
  ///
  /// In en, this message translates to:
  /// **'Please enter your city'**
  String get pleaseSelectYourCity;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @youAreOnTheList.
  ///
  /// In en, this message translates to:
  /// **'You’re on the list'**
  String get youAreOnTheList;

  /// No description provided for @thanksForRegistering.
  ///
  /// In en, this message translates to:
  /// **'Thanks for registering. We’ll let you know as soon as Ryann launches in your area.'**
  String get thanksForRegistering;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @startWithYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Let’s start with your number'**
  String get startWithYourNumber;

  /// No description provided for @otpInfo.
  ///
  /// In en, this message translates to:
  /// **'We’ll send a one-time code to keep Ryann free from fakes.'**
  String get otpInfo;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneNumberVerification.
  ///
  /// In en, this message translates to:
  /// **'Phone Number Verification'**
  String get phoneNumberVerification;

  /// No description provided for @verificationMessage.
  ///
  /// In en, this message translates to:
  /// **'We’ll text you a code to verify you’re really you. Message and data rates may apply.'**
  String get verificationMessage;

  /// No description provided for @numberChangeInfo.
  ///
  /// In en, this message translates to:
  /// **'What happens if your number changes?'**
  String get numberChangeInfo;

  /// No description provided for @notInStateOrCountry.
  ///
  /// In en, this message translates to:
  /// **'Not in this state or country yet?'**
  String get notInStateOrCountry;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @joinTheWaitlist.
  ///
  /// In en, this message translates to:
  /// **'Join the Waitlist'**
  String get joinTheWaitlist;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @enterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterYourEmailAddress;

  /// No description provided for @pleaseSelectYourCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select your country'**
  String get pleaseSelectYourCountry;

  /// No description provided for @thanksForYourInterest.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your interest!'**
  String get thanksForYourInterest;

  /// No description provided for @notifyLaunchMessage.
  ///
  /// In en, this message translates to:
  /// **'We’ll notify you when Ryann launches near you.'**
  String get notifyLaunchMessage;

  /// No description provided for @okay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get okay;

  /// No description provided for @selectCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Select country code'**
  String get selectCountryCode;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyYourNumber;

  /// No description provided for @enterSixDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6 digit code sent to you'**
  String get enterSixDigitCode;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn’t receive a code?'**
  String get didntReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @tellUsAboutYou.
  ///
  /// In en, this message translates to:
  /// **'Tell us about you'**
  String get tellUsAboutYou;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @enterFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @selectBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Select your birth date'**
  String get selectBirthDate;

  /// No description provided for @ageRestrictionNote.
  ///
  /// In en, this message translates to:
  /// **'You must be 18 or older to join Ryann. Your date of birth can’t be changed later.'**
  String get ageRestrictionNote;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderMan.
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get genderMan;

  /// No description provided for @genderWoman.
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get genderWoman;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @genderHelpText.
  ///
  /// In en, this message translates to:
  /// **'This helps us personalise your matches'**
  String get genderHelpText;

  /// No description provided for @pleaseEnterYourDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Please select your date of birth'**
  String get pleaseEnterYourDateOfBirth;

  /// No description provided for @pleaseSelectYourGender.
  ///
  /// In en, this message translates to:
  /// **'Please select your gender'**
  String get pleaseSelectYourGender;

  /// No description provided for @pleaseEnterYourFName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get pleaseEnterYourFName;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Confirm your age is correct, Let’s keep our community authentic.'**
  String get correct;

  /// No description provided for @confirmYourAge.
  ///
  /// In en, this message translates to:
  /// **'Confirm your age'**
  String get confirmYourAge;

  /// No description provided for @youAre.
  ///
  /// In en, this message translates to:
  /// **'You’re'**
  String get youAre;

  /// No description provided for @born.
  ///
  /// In en, this message translates to:
  /// **'Born'**
  String get born;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @whatsYourDob.
  ///
  /// In en, this message translates to:
  /// **'What’s your date of birth?'**
  String get whatsYourDob;

  /// No description provided for @dobUsageInfo.
  ///
  /// In en, this message translates to:
  /// **'We use this to calculate the age on your profile.'**
  String get dobUsageInfo;

  /// No description provided for @activateMembershipPass.
  ///
  /// In en, this message translates to:
  /// **'Activate Your Membership Pass'**
  String get activateMembershipPass;

  /// No description provided for @oneTimeStepNote.
  ///
  /// In en, this message translates to:
  /// **'A one-time step to keep Ryann intentional.'**
  String get oneTimeStepNote;

  /// No description provided for @fullyRedeemable.
  ///
  /// In en, this message translates to:
  /// **'Fully redeemable'**
  String get fullyRedeemable;

  /// No description provided for @oneTimePassDescription.
  ///
  /// In en, this message translates to:
  /// **'One-time pass to access verified matches.'**
  String get oneTimePassDescription;

  /// No description provided for @notSubscription.
  ///
  /// In en, this message translates to:
  /// **'Not a subscription.'**
  String get notSubscription;

  /// No description provided for @activatePass.
  ///
  /// In en, this message translates to:
  /// **'Activate Pass'**
  String get activatePass;

  /// No description provided for @passCreditInfo.
  ///
  /// In en, this message translates to:
  /// **'Your \${name} is credited back to you on Ryann.'**
  String passCreditInfo(String name);

  /// No description provided for @showTheRealYou.
  ///
  /// In en, this message translates to:
  /// **'Show the real you'**
  String get showTheRealYou;

  /// No description provided for @uploadPhotoInstruction.
  ///
  /// In en, this message translates to:
  /// **'Upload 1–2 clear photos of yourself. These will be used for a quick liveness check to confirm your identity.'**
  String get uploadPhotoInstruction;

  /// No description provided for @photosNotVisibleYet.
  ///
  /// In en, this message translates to:
  /// **'Your photos won’t be visible on your profile yet.'**
  String get photosNotVisibleYet;

  /// No description provided for @photosVerificationOnly.
  ///
  /// In en, this message translates to:
  /// **'These photos are used only for verification and will not appear publicly.'**
  String get photosVerificationOnly;

  /// No description provided for @continueToLivenessCheck.
  ///
  /// In en, this message translates to:
  /// **'Continue to Liveness Check'**
  String get continueToLivenessCheck;

  /// No description provided for @uploadAtLeastOnePhoto.
  ///
  /// In en, this message translates to:
  /// **'Please upload at least one photo to proceed to verification.'**
  String get uploadAtLeastOnePhoto;

  /// No description provided for @getPhotoVerified.
  ///
  /// In en, this message translates to:
  /// **'Get Photo Verified'**
  String get getPhotoVerified;

  /// No description provided for @quickSelfieCheck.
  ///
  /// In en, this message translates to:
  /// **'Show you’re real with a quick selfie check.'**
  String get quickSelfieCheck;

  /// No description provided for @everyoneVerifiedInfo.
  ///
  /// In en, this message translates to:
  /// **'Everyone on Ryann is verified — and it starts with this quick selfie check.'**
  String get everyoneVerifiedInfo;

  /// No description provided for @photoVerifiedBadgeInfo.
  ///
  /// In en, this message translates to:
  /// **'Complete a fast, one-time selfie verification to earn your Photo Verified badge.'**
  String get photoVerifiedBadgeInfo;

  /// No description provided for @verificationBenefits.
  ///
  /// In en, this message translates to:
  /// **'It proves you\'re genuine — and verified members receive more trust, more views, and more matches.'**
  String get verificationBenefits;

  /// No description provided for @whatToExpect.
  ///
  /// In en, this message translates to:
  /// **'What to Expect:'**
  String get whatToExpect;

  /// No description provided for @takesLessThanTwoMinutes.
  ///
  /// In en, this message translates to:
  /// **'Takes less than 2 minutes'**
  String get takesLessThanTwoMinutes;

  /// No description provided for @requiredToJoin.
  ///
  /// In en, this message translates to:
  /// **'Required to join Ryann'**
  String get requiredToJoin;

  /// No description provided for @privateAndSecure.
  ///
  /// In en, this message translates to:
  /// **'Private and secure'**
  String get privateAndSecure;

  /// No description provided for @whyThisMatters.
  ///
  /// In en, this message translates to:
  /// **'Why this matters'**
  String get whyThisMatters;

  /// No description provided for @startVerification.
  ///
  /// In en, this message translates to:
  /// **'Start Verification'**
  String get startVerification;

  /// No description provided for @welcomeToRyann.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ryann'**
  String get welcomeToRyann;

  /// No description provided for @honestConnectionsMessage.
  ///
  /// In en, this message translates to:
  /// **'You deserve honest, meaningful connections.'**
  String get honestConnectionsMessage;

  /// No description provided for @verifiedCommunityMessage.
  ///
  /// In en, this message translates to:
  /// **'You’ve joined a verified, intentional community where every match is real, and every connection starts with trust.'**
  String get verifiedCommunityMessage;

  /// No description provided for @noDistractions.
  ///
  /// In en, this message translates to:
  /// **'No distractions.'**
  String get noDistractions;

  /// No description provided for @peopleMeanWhatTheySay.
  ///
  /// In en, this message translates to:
  /// **'Just people who mean what they say.'**
  String get peopleMeanWhatTheySay;

  /// No description provided for @letsGetYouSetUp.
  ///
  /// In en, this message translates to:
  /// **'Let’s Get You Set Up'**
  String get letsGetYouSetUp;

  /// No description provided for @onlyRealPeople.
  ///
  /// In en, this message translates to:
  /// **'Only real people. Only real effort.'**
  String get onlyRealPeople;

  /// No description provided for @setYourIntention.
  ///
  /// In en, this message translates to:
  /// **'Set Your Intention'**
  String get setYourIntention;

  /// No description provided for @chooseWhatYoureLookingFor.
  ///
  /// In en, this message translates to:
  /// **'Choose what you’re looking for'**
  String get chooseWhatYoureLookingFor;

  /// No description provided for @intentionsList.
  ///
  /// In en, this message translates to:
  /// **'Intentions List'**
  String get intentionsList;

  /// No description provided for @lockedForThirtyDays.
  ///
  /// In en, this message translates to:
  /// **'Locked for 30 days'**
  String get lockedForThirtyDays;

  /// No description provided for @longTermLove.
  ///
  /// In en, this message translates to:
  /// **'Long-Term Love, Future Ready'**
  String get longTermLove;

  /// No description provided for @longTermLoveDesc.
  ///
  /// In en, this message translates to:
  /// **'Looking for a meaningful, committed relationship with long-term potential.'**
  String get longTermLoveDesc;

  /// No description provided for @datingWithPossibility.
  ///
  /// In en, this message translates to:
  /// **'Dating with Possibility'**
  String get datingWithPossibility;

  /// No description provided for @datingWithPossibilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Open to a meaningful connection, but not forcing a specific outcome.'**
  String get datingWithPossibilityDesc;

  /// No description provided for @seeingWhereThisGoes.
  ///
  /// In en, this message translates to:
  /// **'Seeing Where This Goes'**
  String get seeingWhereThisGoes;

  /// No description provided for @seeingWhereThisGoesDesc.
  ///
  /// In en, this message translates to:
  /// **'Open to building a connection with honesty and intention — without pressure or a fixed timeline.'**
  String get seeingWhereThisGoesDesc;

  /// No description provided for @friendsFirst.
  ///
  /// In en, this message translates to:
  /// **'Friends First, Maybe More'**
  String get friendsFirst;

  /// No description provided for @friendsFirstDesc.
  ///
  /// In en, this message translates to:
  /// **'Wanting a friendly, fun connection with clear boundaries and no romantic commitment.'**
  String get friendsFirstDesc;

  /// No description provided for @datingIntentionLockWarning.
  ///
  /// In en, this message translates to:
  /// **'Your dating intention will be locked for 30 days to support honest, intentional matching.'**
  String get datingIntentionLockWarning;

  /// No description provided for @whyIsItLocked.
  ///
  /// In en, this message translates to:
  /// **'Why is it locked?'**
  String get whyIsItLocked;

  /// No description provided for @confirmIntention.
  ///
  /// In en, this message translates to:
  /// **'Confirm Intention'**
  String get confirmIntention;

  /// No description provided for @chooseDifferentOne.
  ///
  /// In en, this message translates to:
  /// **'Choose a Different One'**
  String get chooseDifferentOne;

  /// No description provided for @pleaseEnterValidDate.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid date'**
  String get pleaseEnterValidDate;

  /// No description provided for @youMustBeAtLeast18YearsOld.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 18 years old'**
  String get youMustBeAtLeast18YearsOld;

  /// No description provided for @whyIsMyIntentionLockedFor30Days.
  ///
  /// In en, this message translates to:
  /// **'Why is my intention locked for 30 days?'**
  String get whyIsMyIntentionLockedFor30Days;

  /// No description provided for @whyIsMyIntentionLockedFor30DaysDesc.
  ///
  /// In en, this message translates to:
  /// **'Your dating intention stays fixed for 30 days so matches are honest and aligned. This prevents mixed signals and helps everyone date with clarity.'**
  String get whyIsMyIntentionLockedFor30DaysDesc;

  /// No description provided for @youCantChangeThisYet.
  ///
  /// In en, this message translates to:
  /// **'You Can’t Change This Yet'**
  String get youCantChangeThisYet;

  /// No description provided for @intentionLockedInfo.
  ///
  /// In en, this message translates to:
  /// **'Your dating intention is locked for 30 days to keep things clear and consistent for everyone.'**
  String get intentionLockedInfo;

  /// No description provided for @youCanUpdateThisAgainOn.
  ///
  /// In en, this message translates to:
  /// **'You can update this again on:'**
  String get youCanUpdateThisAgainOn;

  /// No description provided for @greatChoiceAllSet.
  ///
  /// In en, this message translates to:
  /// **'Great choice — you’re all set.'**
  String get greatChoiceAllSet;

  /// No description provided for @keepsExpectationsClear.
  ///
  /// In en, this message translates to:
  /// **'This keeps expectations clear and matches aligned.'**
  String get keepsExpectationsClear;

  /// No description provided for @intentionLockedFor30Days.
  ///
  /// In en, this message translates to:
  /// **'Your dating intention is locked for 30 days'**
  String get intentionLockedFor30Days;

  /// No description provided for @learnMoreAboutEachOption.
  ///
  /// In en, this message translates to:
  /// **'Learn more about each option'**
  String get learnMoreAboutEachOption;

  /// No description provided for @aboutEachIntention.
  ///
  /// In en, this message translates to:
  /// **'About Each Intention'**
  String get aboutEachIntention;

  /// No description provided for @lockedFor30Days.
  ///
  /// In en, this message translates to:
  /// **'Locked for 30 days'**
  String get lockedFor30Days;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @aboutEachOption.
  ///
  /// In en, this message translates to:
  /// **'about each option'**
  String get aboutEachOption;

  /// No description provided for @profileBasics.
  ///
  /// In en, this message translates to:
  /// **'Profile Basics'**
  String get profileBasics;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @aFewDetailsOptional.
  ///
  /// In en, this message translates to:
  /// **'A few details. All optional.'**
  String get aFewDetailsOptional;

  /// No description provided for @interestedIn.
  ///
  /// In en, this message translates to:
  /// **'Interested in'**
  String get interestedIn;

  /// No description provided for @men.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get men;

  /// No description provided for @women.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get women;

  /// No description provided for @everyone.
  ///
  /// In en, this message translates to:
  /// **'Everyone'**
  String get everyone;

  /// No description provided for @enterYourSuburbOrCity.
  ///
  /// In en, this message translates to:
  /// **'Enter your suburb or city'**
  String get enterYourSuburbOrCity;

  /// No description provided for @ageRange.
  ///
  /// In en, this message translates to:
  /// **'Age Range'**
  String get ageRange;

  /// No description provided for @matchDistance.
  ///
  /// In en, this message translates to:
  /// **'Match Distance'**
  String get matchDistance;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @selectYourHeight.
  ///
  /// In en, this message translates to:
  /// **'Select your height'**
  String get selectYourHeight;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @yourRoleOrTitle.
  ///
  /// In en, this message translates to:
  /// **'Your role or title'**
  String get yourRoleOrTitle;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @highestLevel.
  ///
  /// In en, this message translates to:
  /// **'Highest level'**
  String get highestLevel;

  /// No description provided for @religion.
  ///
  /// In en, this message translates to:
  /// **'Religion'**
  String get religion;

  /// No description provided for @selectYourReligion.
  ///
  /// In en, this message translates to:
  /// **'Select your religion'**
  String get selectYourReligion;

  /// No description provided for @everythingOptionalNotice.
  ///
  /// In en, this message translates to:
  /// **'Everything here is optional — choose “Prefer not to say” anytime'**
  String get everythingOptionalNotice;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @saveAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & continue'**
  String get saveAndContinue;

  /// No description provided for @reviewYourDetails.
  ///
  /// In en, this message translates to:
  /// **'Review Your Details'**
  String get reviewYourDetails;

  /// No description provided for @confirmBasicDetailsCorrect.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your basic details are correct.'**
  String get confirmBasicDetailsCorrect;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit details'**
  String get editDetails;

  /// No description provided for @confirmAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Confirm & continue'**
  String get confirmAndContinue;

  /// No description provided for @whatAreYouInto.
  ///
  /// In en, this message translates to:
  /// **'What are you into?'**
  String get whatAreYouInto;

  /// No description provided for @chooseUpToEight.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 8 — you can change these anytime'**
  String get chooseUpToEight;

  /// No description provided for @foodAndDrink.
  ///
  /// In en, this message translates to:
  /// **'Food & Drink'**
  String get foodAndDrink;

  /// No description provided for @cooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking'**
  String get cooking;

  /// No description provided for @coffeeLover.
  ///
  /// In en, this message translates to:
  /// **'Coffee Lover'**
  String get coffeeLover;

  /// No description provided for @brunch.
  ///
  /// In en, this message translates to:
  /// **'Brunch'**
  String get brunch;

  /// No description provided for @wine.
  ///
  /// In en, this message translates to:
  /// **'Wine'**
  String get wine;

  /// No description provided for @tryingNewRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Trying New Restaurants'**
  String get tryingNewRestaurants;

  /// No description provided for @fitnessAndWellness.
  ///
  /// In en, this message translates to:
  /// **'Fitness & Wellness'**
  String get fitnessAndWellness;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @pilates.
  ///
  /// In en, this message translates to:
  /// **'Pilates'**
  String get pilates;

  /// No description provided for @yoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get yoga;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @hiking.
  ///
  /// In en, this message translates to:
  /// **'Hiking'**
  String get hiking;

  /// No description provided for @wellnessAndMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Wellness & Mindfulness'**
  String get wellnessAndMindfulness;

  /// No description provided for @travelAndOutdoors.
  ///
  /// In en, this message translates to:
  /// **'Travel & Outdoors'**
  String get travelAndOutdoors;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @beaches.
  ///
  /// In en, this message translates to:
  /// **'Beaches'**
  String get beaches;

  /// No description provided for @nature.
  ///
  /// In en, this message translates to:
  /// **'Nature'**
  String get nature;

  /// No description provided for @weekendGetaways.
  ///
  /// In en, this message translates to:
  /// **'Weekend Getaways'**
  String get weekendGetaways;

  /// No description provided for @musicAndEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Music & Entertainment'**
  String get musicAndEntertainment;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @concerts.
  ///
  /// In en, this message translates to:
  /// **'Concerts'**
  String get concerts;

  /// No description provided for @festivals.
  ///
  /// In en, this message translates to:
  /// **'Festivals'**
  String get festivals;

  /// No description provided for @movies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies;

  /// No description provided for @tvShows.
  ///
  /// In en, this message translates to:
  /// **'TV Shows'**
  String get tvShows;

  /// No description provided for @podcasts.
  ///
  /// In en, this message translates to:
  /// **'Podcasts'**
  String get podcasts;

  /// No description provided for @pets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get pets;

  /// No description provided for @dogs.
  ///
  /// In en, this message translates to:
  /// **'Dogs'**
  String get dogs;

  /// No description provided for @cats.
  ///
  /// In en, this message translates to:
  /// **'Cats'**
  String get cats;

  /// No description provided for @creativeAndHobbies.
  ///
  /// In en, this message translates to:
  /// **'Creative & Hobbies'**
  String get creativeAndHobbies;

  /// No description provided for @photography.
  ///
  /// In en, this message translates to:
  /// **'Photography'**
  String get photography;

  /// No description provided for @artAndDesign.
  ///
  /// In en, this message translates to:
  /// **'Art & Design'**
  String get artAndDesign;

  /// No description provided for @fashion.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashion;

  /// No description provided for @diyCrafts.
  ///
  /// In en, this message translates to:
  /// **'DIY / Crafts'**
  String get diyCrafts;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @writing.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get writing;

  /// No description provided for @lifestyleAndGrowth.
  ///
  /// In en, this message translates to:
  /// **'Lifestyle & Growth'**
  String get lifestyleAndGrowth;

  /// No description provided for @fitnessLifestyle.
  ///
  /// In en, this message translates to:
  /// **'Fitness Lifestyle'**
  String get fitnessLifestyle;

  /// No description provided for @selfImprovement.
  ///
  /// In en, this message translates to:
  /// **'Self-Improvement'**
  String get selfImprovement;

  /// No description provided for @entrepreneurship.
  ///
  /// In en, this message translates to:
  /// **'Entrepreneurship'**
  String get entrepreneurship;

  /// No description provided for @spirituality.
  ///
  /// In en, this message translates to:
  /// **'Spirituality'**
  String get spirituality;

  /// No description provided for @astrology.
  ///
  /// In en, this message translates to:
  /// **'Astrology'**
  String get astrology;

  /// No description provided for @howImportantToShareInterests.
  ///
  /// In en, this message translates to:
  /// **'How important is it to you to share interests with a match?'**
  String get howImportantToShareInterests;

  /// No description provided for @yesItsImportant.
  ///
  /// In en, this message translates to:
  /// **'Yes, it’s important'**
  String get yesItsImportant;

  /// No description provided for @iDontMind.
  ///
  /// In en, this message translates to:
  /// **'I don’t mind'**
  String get iDontMind;

  /// No description provided for @noItsNotImportant.
  ///
  /// In en, this message translates to:
  /// **'No, it’s not important'**
  String get noItsNotImportant;

  /// No description provided for @youCanOnlySelect8Interests.
  ///
  /// In en, this message translates to:
  /// **'You can only select 8 interests'**
  String get youCanOnlySelect8Interests;

  /// No description provided for @pleaseSelectAtLeastOneInterest.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one interest'**
  String get pleaseSelectAtLeastOneInterest;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutMe;

  /// No description provided for @yourStoryMatters.
  ///
  /// In en, this message translates to:
  /// **'Your story matters. Tell us a little about you.'**
  String get yourStoryMatters;

  /// No description provided for @writeSomethingShort.
  ///
  /// In en, this message translates to:
  /// **'Write something short about yourself...'**
  String get writeSomethingShort;

  /// No description provided for @useAiToHelp.
  ///
  /// In en, this message translates to:
  /// **'Use AI to help'**
  String get useAiToHelp;

  /// No description provided for @stuckLetAiHelp.
  ///
  /// In en, this message translates to:
  /// **'Stuck? Let AI help you write a bio that sounds like you.'**
  String get stuckLetAiHelp;

  /// No description provided for @bioAnytimeNote.
  ///
  /// In en, this message translates to:
  /// **'You can add or edit your bio anytime.'**
  String get bioAnytimeNote;

  /// No description provided for @warm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get warm;

  /// No description provided for @playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get playful;

  /// No description provided for @confident.
  ///
  /// In en, this message translates to:
  /// **'Confident'**
  String get confident;

  /// No description provided for @minimal.
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get minimal;

  /// No description provided for @suggestionN.
  ///
  /// In en, this message translates to:
  /// **'Suggestion {number}'**
  String suggestionN(int number);

  /// No description provided for @useThis.
  ///
  /// In en, this message translates to:
  /// **'Use This'**
  String get useThis;

  /// No description provided for @buildCompatibilityRing.
  ///
  /// In en, this message translates to:
  /// **'Build Your Compatibility Ring'**
  String get buildCompatibilityRing;

  /// No description provided for @optionalQuestionsForBetterMatches.
  ///
  /// In en, this message translates to:
  /// **'Optional questions for better-aligned matches.'**
  String get optionalQuestionsForBetterMatches;

  /// No description provided for @findYourMatch.
  ///
  /// In en, this message translates to:
  /// **'Find Your'**
  String get findYourMatch;

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'Match'**
  String get match;

  /// No description provided for @startCompatibilityQuestions.
  ///
  /// In en, this message translates to:
  /// **'Start Compatibility Questions'**
  String get startCompatibilityQuestions;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get skipForNow;

  /// No description provided for @youCanComeBackThisAnytime.
  ///
  /// In en, this message translates to:
  /// **'You can come back to this anytime.'**
  String get youCanComeBackThisAnytime;

  /// No description provided for @theMoreYouAnswer.
  ///
  /// In en, this message translates to:
  /// **'The more you answer, the more accurate your compatibility becomes'**
  String get theMoreYouAnswer;

  /// No description provided for @buildMyCompatibilityRing.
  ///
  /// In en, this message translates to:
  /// **'Build My Compatibility Ring'**
  String get buildMyCompatibilityRing;

  /// No description provided for @answersStayPrivate.
  ///
  /// In en, this message translates to:
  /// **'Your answers stay private and only shape your match suggestions.'**
  String get answersStayPrivate;

  /// No description provided for @familyAndFuture.
  ///
  /// In en, this message translates to:
  /// **'Family & Future'**
  String get familyAndFuture;

  /// No description provided for @familyAndFutureDesc.
  ///
  /// In en, this message translates to:
  /// **'Kids, timing, future plans'**
  String get familyAndFutureDesc;

  /// No description provided for @lifestyleAndHabits.
  ///
  /// In en, this message translates to:
  /// **'Lifestyle & Habits'**
  String get lifestyleAndHabits;

  /// No description provided for @lifestyleAndHabitsDesc.
  ///
  /// In en, this message translates to:
  /// **'Fitness, routines, sleep, alcohol, smoking'**
  String get lifestyleAndHabitsDesc;

  /// No description provided for @socialEnergy.
  ///
  /// In en, this message translates to:
  /// **'Social Energy'**
  String get socialEnergy;

  /// No description provided for @socialEnergyDesc.
  ///
  /// In en, this message translates to:
  /// **'Introvert/extrovert, weekend vibe'**
  String get socialEnergyDesc;

  /// No description provided for @communicationStyle.
  ///
  /// In en, this message translates to:
  /// **'Communication Style'**
  String get communicationStyle;

  /// No description provided for @communicationStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'How you connect and stay in touch'**
  String get communicationStyleDesc;

  /// No description provided for @conflictStyle.
  ///
  /// In en, this message translates to:
  /// **'Conflict Style'**
  String get conflictStyle;

  /// No description provided for @conflictStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'How you handle disagreements'**
  String get conflictStyleDesc;

  /// No description provided for @intimacyExpectations.
  ///
  /// In en, this message translates to:
  /// **'Intimacy Expectations'**
  String get intimacyExpectations;

  /// No description provided for @intimacyExpectationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Affection, closeness, boundaries'**
  String get intimacyExpectationsDesc;

  /// No description provided for @valuesAndPriorities.
  ///
  /// In en, this message translates to:
  /// **'Values & Priorities'**
  String get valuesAndPriorities;

  /// No description provided for @valuesAndPrioritiesDesc.
  ///
  /// In en, this message translates to:
  /// **'Values + deal-breakers'**
  String get valuesAndPrioritiesDesc;

  /// No description provided for @familyPlans.
  ///
  /// In en, this message translates to:
  /// **'Family Plans'**
  String get familyPlans;

  /// No description provided for @doYouHaveOrWantKids.
  ///
  /// In en, this message translates to:
  /// **'Do you have or want kids?'**
  String get doYouHaveOrWantKids;

  /// No description provided for @iWantKids.
  ///
  /// In en, this message translates to:
  /// **'I want kids'**
  String get iWantKids;

  /// No description provided for @iDontWantKids.
  ///
  /// In en, this message translates to:
  /// **'I don’t want kids'**
  String get iDontWantKids;

  /// No description provided for @imUnsure.
  ///
  /// In en, this message translates to:
  /// **'I’m unsure'**
  String get imUnsure;

  /// No description provided for @iAlreadyHaveKids.
  ///
  /// In en, this message translates to:
  /// **'I already have kids'**
  String get iAlreadyHaveKids;

  /// No description provided for @whenAreYouHopingToHaveKids.
  ///
  /// In en, this message translates to:
  /// **'When are you hoping to have kids?'**
  String get whenAreYouHopingToHaveKids;

  /// No description provided for @asSoonAsPossible.
  ///
  /// In en, this message translates to:
  /// **'As soon as possible'**
  String get asSoonAsPossible;

  /// No description provided for @inNext1To2Years.
  ///
  /// In en, this message translates to:
  /// **'In the next 1-2 years'**
  String get inNext1To2Years;

  /// No description provided for @inNext3To5Years.
  ///
  /// In en, this message translates to:
  /// **'In the next 3-5 years'**
  String get inNext3To5Years;

  /// No description provided for @someday.
  ///
  /// In en, this message translates to:
  /// **'Someday'**
  String get someday;

  /// No description provided for @notAnytimeSoon.
  ///
  /// In en, this message translates to:
  /// **'Not anytime soon'**
  String get notAnytimeSoon;

  /// No description provided for @whatsYourRelationshipWithFitness.
  ///
  /// In en, this message translates to:
  /// **'What’s your relationship with fitness?'**
  String get whatsYourRelationshipWithFitness;

  /// No description provided for @fitnessBigPartOfLife.
  ///
  /// In en, this message translates to:
  /// **'Fitness is a big part of my life'**
  String get fitnessBigPartOfLife;

  /// No description provided for @iWorkOutRegularly.
  ///
  /// In en, this message translates to:
  /// **'I work out regularly'**
  String get iWorkOutRegularly;

  /// No description provided for @iWorkOutOccasionally.
  ///
  /// In en, this message translates to:
  /// **'I work out occasionally'**
  String get iWorkOutOccasionally;

  /// No description provided for @notIntoFitness.
  ///
  /// In en, this message translates to:
  /// **'Not into fitness'**
  String get notIntoFitness;

  /// No description provided for @preferPartnerSimilarFitness.
  ///
  /// In en, this message translates to:
  /// **'Do you prefer a partner with a similar fitness lifestyle?'**
  String get preferPartnerSimilarFitness;

  /// No description provided for @itsNiceBonus.
  ///
  /// In en, this message translates to:
  /// **'It’s a nice bonus'**
  String get itsNiceBonus;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @saveAndComeBackLater.
  ///
  /// In en, this message translates to:
  /// **'Save & come back later'**
  String get saveAndComeBackLater;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @howManyKidsIdeally.
  ///
  /// In en, this message translates to:
  /// **'How many kids do you ideally want?'**
  String get howManyKidsIdeally;

  /// No description provided for @kidsUndecided.
  ///
  /// In en, this message translates to:
  /// **'Undecided'**
  String get kidsUndecided;

  /// No description provided for @openToMoreKids.
  ///
  /// In en, this message translates to:
  /// **'Would you be open to having more kids?'**
  String get openToMoreKids;

  /// No description provided for @maybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe'**
  String get maybe;

  /// No description provided for @onlyDateSingleParents.
  ///
  /// In en, this message translates to:
  /// **'Only date single parents'**
  String get onlyDateSingleParents;

  /// No description provided for @datePeopleWithKids.
  ///
  /// In en, this message translates to:
  /// **'Do you date people who have kids?'**
  String get datePeopleWithKids;

  /// No description provided for @relationshipWithFitness.
  ///
  /// In en, this message translates to:
  /// **'What’s your relationship with fitness?'**
  String get relationshipWithFitness;

  /// No description provided for @weekdayWakeUpTime.
  ///
  /// In en, this message translates to:
  /// **'When do you usually wake up on weekdays?'**
  String get weekdayWakeUpTime;

  /// No description provided for @before6am.
  ///
  /// In en, this message translates to:
  /// **'Before 6 AM'**
  String get before6am;

  /// No description provided for @between6And7am.
  ///
  /// In en, this message translates to:
  /// **'6–7 AM'**
  String get between6And7am;

  /// No description provided for @between7And8am.
  ///
  /// In en, this message translates to:
  /// **'7–8 AM'**
  String get between7And8am;

  /// No description provided for @after8am.
  ///
  /// In en, this message translates to:
  /// **'After 8 AM'**
  String get after8am;

  /// No description provided for @sleepPatternImportance.
  ///
  /// In en, this message translates to:
  /// **'How important is having a similar sleep/wake pattern to your partner?'**
  String get sleepPatternImportance;

  /// No description provided for @veryImportant.
  ///
  /// In en, this message translates to:
  /// **'Very important'**
  String get veryImportant;

  /// No description provided for @somewhatImportant.
  ///
  /// In en, this message translates to:
  /// **'Somewhat important'**
  String get somewhatImportant;

  /// No description provided for @notImportant.
  ///
  /// In en, this message translates to:
  /// **'Not important'**
  String get notImportant;

  /// No description provided for @drinkAlcohol.
  ///
  /// In en, this message translates to:
  /// **'Do you drink alcohol?'**
  String get drinkAlcohol;

  /// No description provided for @drinkOccasionally.
  ///
  /// In en, this message translates to:
  /// **'Occasionally'**
  String get drinkOccasionally;

  /// No description provided for @smoke.
  ///
  /// In en, this message translates to:
  /// **'Do you smoke?'**
  String get smoke;

  /// No description provided for @smokingDealBreaker.
  ///
  /// In en, this message translates to:
  /// **'If you don’t smoke, is it a deal breaker if your partner does?'**
  String get smokingDealBreaker;

  /// No description provided for @dealBreaker.
  ///
  /// In en, this message translates to:
  /// **'Yes, deal-breaker'**
  String get dealBreaker;

  /// No description provided for @preferTheyDont.
  ///
  /// In en, this message translates to:
  /// **'Prefer they don’t'**
  String get preferTheyDont;

  /// No description provided for @dontMind.
  ///
  /// In en, this message translates to:
  /// **'Don’t mind'**
  String get dontMind;

  /// No description provided for @socialEnergyImportance.
  ///
  /// In en, this message translates to:
  /// **'How important is having similar social energy?'**
  String get socialEnergyImportance;

  /// No description provided for @idealWeekendVibe.
  ///
  /// In en, this message translates to:
  /// **'Ideal weekend vibe?'**
  String get idealWeekendVibe;

  /// No description provided for @outWithFriends.
  ///
  /// In en, this message translates to:
  /// **'Out with friends'**
  String get outWithFriends;

  /// No description provided for @quietAtHome.
  ///
  /// In en, this message translates to:
  /// **'Quiet time at home'**
  String get quietAtHome;

  /// No description provided for @mixOfBoth.
  ///
  /// In en, this message translates to:
  /// **'A mix of both'**
  String get mixOfBoth;

  /// No description provided for @introvert.
  ///
  /// In en, this message translates to:
  /// **'Introvert'**
  String get introvert;

  /// No description provided for @extrovert.
  ///
  /// In en, this message translates to:
  /// **'Extrovert'**
  String get extrovert;

  /// No description provided for @ambivert.
  ///
  /// In en, this message translates to:
  /// **'Ambivert'**
  String get ambivert;

  /// No description provided for @communicationFrequency.
  ///
  /// In en, this message translates to:
  /// **'How often do you like to hear from someone you\'re interested in?'**
  String get communicationFrequency;

  /// No description provided for @multipleTimesADay.
  ///
  /// In en, this message translates to:
  /// **'Multiple times a day'**
  String get multipleTimesADay;

  /// No description provided for @onceADay.
  ///
  /// In en, this message translates to:
  /// **'Once a day'**
  String get onceADay;

  /// No description provided for @everyFewDays.
  ///
  /// In en, this message translates to:
  /// **'Every few days'**
  String get everyFewDays;

  /// No description provided for @noSetPreference.
  ///
  /// In en, this message translates to:
  /// **'No set preference'**
  String get noSetPreference;

  /// No description provided for @lateReplyFeeling.
  ///
  /// In en, this message translates to:
  /// **'If someone replies late, how do you usually feel?'**
  String get lateReplyFeeling;

  /// No description provided for @itUpsetsMe.
  ///
  /// In en, this message translates to:
  /// **'It upsets me'**
  String get itUpsetsMe;

  /// No description provided for @iGetInMyHead.
  ///
  /// In en, this message translates to:
  /// **'I get in my head'**
  String get iGetInMyHead;

  /// No description provided for @noticeButFine.
  ///
  /// In en, this message translates to:
  /// **'I notice it, but I’m fine'**
  String get noticeButFine;

  /// No description provided for @doesntBotherMe.
  ///
  /// In en, this message translates to:
  /// **'It doesn’t bother me'**
  String get doesntBotherMe;

  /// No description provided for @communicationProblems.
  ///
  /// In en, this message translates to:
  /// **'Has your communication style caused problems?'**
  String get communicationProblems;

  /// No description provided for @often.
  ///
  /// In en, this message translates to:
  /// **'Often'**
  String get often;

  /// No description provided for @sometimes.
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get sometimes;

  /// No description provided for @rarely.
  ///
  /// In en, this message translates to:
  /// **'Rarely'**
  String get rarely;

  /// No description provided for @handleDisagreements.
  ///
  /// In en, this message translates to:
  /// **'How do you usually handle disagreements?'**
  String get handleDisagreements;

  /// No description provided for @talkImmediately.
  ///
  /// In en, this message translates to:
  /// **'Talk it out immediately'**
  String get talkImmediately;

  /// No description provided for @takeTimeToProcess.
  ///
  /// In en, this message translates to:
  /// **'Take time to process'**
  String get takeTimeToProcess;

  /// No description provided for @walkAway.
  ///
  /// In en, this message translates to:
  /// **'Walk away'**
  String get walkAway;

  /// No description provided for @shutDown.
  ///
  /// In en, this message translates to:
  /// **'Stay but shut down'**
  String get shutDown;

  /// No description provided for @becomeReactive.
  ///
  /// In en, this message translates to:
  /// **'Become reactive'**
  String get becomeReactive;

  /// No description provided for @useHumour.
  ///
  /// In en, this message translates to:
  /// **'Use humour'**
  String get useHumour;

  /// No description provided for @stayCalm.
  ///
  /// In en, this message translates to:
  /// **'Stay calm no matter what'**
  String get stayCalm;

  /// No description provided for @intimacyDefinition.
  ///
  /// In en, this message translates to:
  /// **'What does intimacy look like to you?'**
  String get intimacyDefinition;

  /// No description provided for @physicalCloseness.
  ///
  /// In en, this message translates to:
  /// **'Physical closeness'**
  String get physicalCloseness;

  /// No description provided for @emotionalFirst.
  ///
  /// In en, this message translates to:
  /// **'Emotional connection first'**
  String get emotionalFirst;

  /// No description provided for @balanceBoth.
  ///
  /// In en, this message translates to:
  /// **'A balance of both'**
  String get balanceBoth;

  /// No description provided for @gradualIntimacy.
  ///
  /// In en, this message translates to:
  /// **'Gradual intimacy over time'**
  String get gradualIntimacy;

  /// No description provided for @physicalAffectionImportance.
  ///
  /// In en, this message translates to:
  /// **'How important is physical affection in a relationship?'**
  String get physicalAffectionImportance;

  /// No description provided for @pdaComfort.
  ///
  /// In en, this message translates to:
  /// **'How comfortable are you with public displays of affection (PDA)?'**
  String get pdaComfort;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @somewhatComfortable.
  ///
  /// In en, this message translates to:
  /// **'Somewhat comfortable'**
  String get somewhatComfortable;

  /// No description provided for @veryComfortable.
  ///
  /// In en, this message translates to:
  /// **'Very comfortable'**
  String get veryComfortable;

  /// No description provided for @uncomfortable.
  ///
  /// In en, this message translates to:
  /// **'Uncomfortable'**
  String get uncomfortable;

  /// No description provided for @reassuranceResponse.
  ///
  /// In en, this message translates to:
  /// **'When a partner needs reassurance or closeness, you usually feel…?'**
  String get reassuranceResponse;

  /// No description provided for @comfortableResponsive.
  ///
  /// In en, this message translates to:
  /// **'Comfortable and responsive'**
  String get comfortableResponsive;

  /// No description provided for @comfortableNeedSpace.
  ///
  /// In en, this message translates to:
  /// **'Comfortable, but I need space sometimes'**
  String get comfortableNeedSpace;

  /// No description provided for @feelTense.
  ///
  /// In en, this message translates to:
  /// **'I can feel unsure or tense'**
  String get feelTense;

  /// No description provided for @feelOverwhelmed.
  ///
  /// In en, this message translates to:
  /// **'I feel overwhelmed by it'**
  String get feelOverwhelmed;

  /// No description provided for @intimacyMismatchTension.
  ///
  /// In en, this message translates to:
  /// **'If intimacy needs don’t align, how much tension does that usually create for you?'**
  String get intimacyMismatchTension;

  /// No description provided for @dealBreakerTension.
  ///
  /// In en, this message translates to:
  /// **'A lot — it’s a deal-breaker for me'**
  String get dealBreakerTension;

  /// No description provided for @ongoingFriction.
  ///
  /// In en, this message translates to:
  /// **'Some — it causes ongoing friction'**
  String get ongoingFriction;

  /// No description provided for @littleTension.
  ///
  /// In en, this message translates to:
  /// **'A little — we usually work through it'**
  String get littleTension;

  /// No description provided for @noTension.
  ///
  /// In en, this message translates to:
  /// **'None — it doesn’t really affect me'**
  String get noTension;

  /// No description provided for @careerAndSuccess.
  ///
  /// In en, this message translates to:
  /// **'Career & success'**
  String get careerAndSuccess;

  /// No description provided for @familyAndChildren.
  ///
  /// In en, this message translates to:
  /// **'Family & children'**
  String get familyAndChildren;

  /// No description provided for @stability.
  ///
  /// In en, this message translates to:
  /// **'Stability'**
  String get stability;

  /// No description provided for @travelAndExperiences.
  ///
  /// In en, this message translates to:
  /// **'Travel & experiences'**
  String get travelAndExperiences;

  /// No description provided for @healthAndFitness.
  ///
  /// In en, this message translates to:
  /// **'Health & fitness'**
  String get healthAndFitness;

  /// No description provided for @financialGoals.
  ///
  /// In en, this message translates to:
  /// **'Financial goals'**
  String get financialGoals;

  /// No description provided for @chooseUpToThree.
  ///
  /// In en, this message translates to:
  /// **'You can choose up to 3'**
  String get chooseUpToThree;

  /// No description provided for @chooseUpToThreeValues.
  ///
  /// In en, this message translates to:
  /// **'Choose up to 3 values that matter most to you in a partner.'**
  String get chooseUpToThreeValues;

  /// No description provided for @selectUpToThreeDealBreakers.
  ///
  /// In en, this message translates to:
  /// **'Select up to 3 things you’re not willing to compromise on.'**
  String get selectUpToThreeDealBreakers;

  /// No description provided for @dealBreakersTitle.
  ///
  /// In en, this message translates to:
  /// **'Your deal breakers'**
  String get dealBreakersTitle;

  /// No description provided for @lackOfAmbition.
  ///
  /// In en, this message translates to:
  /// **'Lack of ambition'**
  String get lackOfAmbition;

  /// No description provided for @poorCommunication.
  ///
  /// In en, this message translates to:
  /// **'Poor communication'**
  String get poorCommunication;

  /// No description provided for @emotionalImmaturity.
  ///
  /// In en, this message translates to:
  /// **'Emotional immaturity'**
  String get emotionalImmaturity;

  /// No description provided for @smoking.
  ///
  /// In en, this message translates to:
  /// **'Smoking'**
  String get smoking;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @heavyDrinking.
  ///
  /// In en, this message translates to:
  /// **'Heavy drinking'**
  String get heavyDrinking;

  /// No description provided for @jealousyIssues.
  ///
  /// In en, this message translates to:
  /// **'Jealousy issues'**
  String get jealousyIssues;

  /// No description provided for @differentFamilyGoals.
  ///
  /// In en, this message translates to:
  /// **'Different family goals'**
  String get differentFamilyGoals;

  /// No description provided for @noQuestionFound.
  ///
  /// In en, this message translates to:
  /// **'No question found'**
  String get noQuestionFound;

  /// No description provided for @choose12Prompts.
  ///
  /// In en, this message translates to:
  /// **'Choose 1–2 prompts'**
  String get choose12Prompts;

  /// No description provided for @promptsHelpYourMatchesGetFeelForYourPersonality.
  ///
  /// In en, this message translates to:
  /// **'Prompts help your matches get a feel for your personality.'**
  String get promptsHelpYourMatchesGetFeelForYourPersonality;

  /// No description provided for @yourAnswersWillAppearOnYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your answers will appear on your profile'**
  String get yourAnswersWillAppearOnYourProfile;

  /// No description provided for @createACustomPrompt.
  ///
  /// In en, this message translates to:
  /// **'Create a custom prompt'**
  String get createACustomPrompt;

  /// No description provided for @pleaseSelectSharingImportance.
  ///
  /// In en, this message translates to:
  /// **'Please select sharing importance'**
  String get pleaseSelectSharingImportance;

  /// No description provided for @noCountryFound.
  ///
  /// In en, this message translates to:
  /// **'No country found'**
  String get noCountryFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
