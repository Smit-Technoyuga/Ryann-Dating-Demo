import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/pages/splash_screen/cubit/splash_cubit.dart';
import 'package:ryann_dating/app/pages/splash_screen/cubit/splash_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/status_bar_theme.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController!.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: StatusBarTheme.whitePrimary,
      child: BlocProvider(
        create: (context) => SplashCubit()..startSplash(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateToWelcome) {
              context.go(AppRoutes.welcome);
            } else if (state is SplashAuthenticated) {
              context.read<ProfileCubit>().getProfile(context);
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.darkPrimary,
            body: Stack(
              alignment: .center,
              children: [
                Positioned(
                  top: 0,
                  child: ValueListenableBuilder(
                    valueListenable: _animationController!,
                    builder: (context, value, child) => AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: value,
                      child: CustomImageView(
                        imagePath: Assets.svgIcons.splashBack,
                        width: context.width,
                        fit: .contain,
                      ),
                    ),
                  ),
                ),
                Align(
                  child: ValueListenableBuilder(
                    valueListenable: _animationController!,
                    builder: (context, value, child) => Column(
                      mainAxisAlignment: .center,
                      spacing: Tween<double>(
                        begin: 0,
                        end: 40,
                      ).animate(_animationController!).value,
                      children: [
                        CustomImageView(
                          imagePath: Assets.logo.logoIc,
                          fit: .contain,
                          width: 80,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: value,
                          child: SizedBox(
                            height: Tween<double>(
                              begin: 0,
                              end: 40,
                            ).animate(_animationController!).value,
                            child: Text(
                              context.l10n.welcomeTheGood,
                              style: AppTextStyle.s18w500(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
