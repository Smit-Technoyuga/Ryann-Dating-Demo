import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/interest_model/interest_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/city_selection_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/login_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/membership_screen/membership_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/otp_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/register_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/about_me_screen/about_me_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/about_me_screen/cubit/about_me_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/dob_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/tell_us_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_questions_list_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_questions_screen.dart.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_ring_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intention_confirmation_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intention_locked_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intention_selection_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intention_set_success_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intentions_list_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/welcome_intention_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/interests_screen/cubit/interests_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/interests_screen/interests_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/about_each_intention_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/add_photo_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/photo_verification_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/profile_basics_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/review_details_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/custom_prompt_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/prompts_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/welcome_screen.dart';
import 'package:ryann_dating/app/pages/dashboard/dashboard_screen.dart';
import 'package:ryann_dating/app/pages/splash_screen/splash_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';

class AppPages {
  static const initial = Routes.initial;

  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.initial,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomeScreen();
        },
        routes: [
          GoRoute(
            path: Routes.citySelectionScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const CitySelectionScreen();
            },
            routes: [
              GoRoute(
                path: Routes.register,
                builder: (BuildContext context, GoRouterState state) {
                  final cubit = state.extra! as AuthCubit;
                  return BlocProvider.value(
                    value: cubit,
                    child: const RegisterScreen(),
                  );
                },
              ),
              GoRoute(
                path: Routes.login,
                builder: (BuildContext context, GoRouterState state) {
                  final cubit = state.extra! as AuthCubit;
                  return BlocProvider.value(
                    value: cubit,
                    child: const LoginScreen(isLogin: false),
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.otp,
                    builder: (BuildContext context, GoRouterState state) {
                      final cubit = state.extra! as AuthCubit;
                      cubit.state.otpController.clear();
                      cubit.setIsRegister(value: true);
                      return BlocProvider.value(
                        value: cubit,
                        child: const OtpScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          GoRoute(
            path: Routes.login,
            builder: (BuildContext context, GoRouterState state) {
              return const LoginScreen(isLogin: true);
            },
            routes: [
              GoRoute(
                path: Routes.otp,
                builder: (BuildContext context, GoRouterState state) {
                  final cubit = state.extra! as AuthCubit;
                  cubit.state.otpController.clear();
                  return BlocProvider.value(
                    value: cubit,
                    child: const OtpScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.tellUsAbout,
            builder: (BuildContext context, GoRouterState state) {
              return const TellUsScreen();
            },
            routes: [
              GoRoute(
                path: Routes.dob,
                builder: (BuildContext context, GoRouterState state) {
                  final cubit = state.extra! as BasicInfoCubit;
                  return BlocProvider.value(
                    value: cubit,
                    child: const DobScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.membershipScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const MembershipScreen();
            },
          ),
          GoRoute(
            path: Routes.addPhoto,
            builder: (BuildContext context, GoRouterState state) {
              return const AddPhotoScreen();
            },
            routes: [
              GoRoute(
                path: Routes.photoVerification,
                builder: (BuildContext context, GoRouterState state) {
                  return const PhotoVerificationScreen();
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.welcomeIntentionSelection,
            builder: (BuildContext context, GoRouterState state) {
              return WelcomeIntentionScreen(
                intentions: state.extra != null
                    ? state.extra! as List<IntentionModel>
                    : [],
              );
            },
            routes: [
              GoRoute(
                path: Routes.intentionSelection,
                builder: (BuildContext context, GoRouterState state) {
                  return IntentionSelectionScreen(
                    intentions: state.extra != null
                        ? state.extra! as List<IntentionModel>
                        : [],
                  );
                },
                routes: [
                  GoRoute(
                    path: Routes.intentionConfirmation,
                    builder: (BuildContext context, GoRouterState state) {
                      final extra = state.extra! as IntentionSelectionCubit;
                      return BlocProvider.value(
                        value: extra,
                        child: const IntentionConfirmationScreen(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          GoRoute(
            path: Routes.intentionSetSuccess,
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra! as List<IntentionModel>;
              return IntentionSetSuccessScreen(intentions: extra);
            },
          ),
          GoRoute(
            path: Routes.intentionLocked,
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra! as List<IntentionModel>;
              return IntentionLockedScreen(intentions: extra);
            },
            routes: [
              GoRoute(
                path: Routes.intentionsList,
                builder: (BuildContext context, GoRouterState state) {
                  final extra = state.extra! as List<IntentionModel>;
                  return IntentionsListScreen(intentions: extra);
                },
                routes: [
                  GoRoute(
                    path: Routes.aboutEachIntention,
                    builder: (BuildContext context, GoRouterState state) {
                      return const AboutEachIntentionScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: Routes.profileBasics,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfileBasicsScreen();
            },
            routes: [
              GoRoute(
                path: Routes.reviewDetails,
                builder: (BuildContext context, GoRouterState state) {
                  final cubit = state.extra! as ProfileBasicsCubit;
                  return BlocProvider.value(
                    value: cubit,
                    child: const ReviewDetailsScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.interests,
            name: AppRoutes.interests,
            builder: (context, state) {
              final interests = state.extra as List<InterestModel>?;
              return BlocProvider(
                create: (context) =>
                    InterestsCubit(context, interests: interests ?? []),
                child: const InterestsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.aboutMe,
                name: AppRoutes.aboutMe,
                builder: (context, state) => BlocProvider(
                  create: (context) => AboutMeCubit(),
                  child: const AboutMeScreen(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Routes.prompts,
            name: AppRoutes.prompts,
            builder: (context, state) {
              final prompts = state.extra as List<PromptModel>?;
              return BlocProvider(
                create: (context) => PromptsCubit(prompts ?? []),
                child: const PromptsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: Routes.customPrompt,
                name: AppRoutes.customPrompt,
                builder: (context, state) {
                  final cubit = state.extra! as PromptsCubit;
                  return BlocProvider.value(
                    value: cubit,
                    child: const CustomPromptScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: Routes.compatibilityRing,
            name: AppRoutes.compatibilityRing,
            builder: (context, state) {
              final extra = state.extra as CompatibilityRingScreenArgs?;
              return CompatibilityRingScreen(args: extra);
            },
            routes: [
              GoRoute(
                path: Routes.compatibilityQuestions,
                name: AppRoutes.compatibilityQuestions,
                builder: (context, state) {
                  final extra = state.extra as CompatibilityRingScreenArgs?;
                  return CompatibilityQuestionsScreen(args: extra);
                },
                routes: [
                  GoRoute(
                    path: Routes.compatibilityQuestionsList,
                    name: AppRoutes.compatibilityQuestionsList,
                    builder: (context, state) {
                      final extra = state.extra as CompatibilityRingScreenArgs?;
                      return CompatibilityQuestionsListScreen(args: extra);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.dashboard,
        name: AppRoutes.dashboard,
        builder: (context, state) {
          return const DashboardScreen();
        },
      ),
    ],
  );
}
