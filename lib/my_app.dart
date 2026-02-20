import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/routes/app_pages.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/widgets/connectivity_wrapper.dart';
import 'package:ryann_dating/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<ProfileCubit>())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        // child: MaterialApp(
        //   debugShowCheckedModeBanner: false,
        //   home: CameraPage(),
        // ),
        child: MaterialApp.router(
          routerConfig: AppPages.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: AppColors.whiteColor,
            primaryColor: AppColors.primaryColor,
            colorScheme: ColorScheme.fromSeed(
              error: AppColors.errorColor,
              seedColor: AppColors.primaryColor,
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return ConnectivityWrapper(child: FlutterEasyLoading(child: child));
          },
        ),
      ),
    );
  }
}
