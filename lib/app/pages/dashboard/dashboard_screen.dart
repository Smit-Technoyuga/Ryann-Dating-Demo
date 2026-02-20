import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/storage_service.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/status_bar_theme.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final cubit = context.read<DashboardCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              systemOverlayStyle: StatusBarTheme.darkWhite,
              elevation: 0,
              leading: IconButton(
                onPressed: () {},
                icon: CustomImageView(
                  imagePath: Assets.svgIcons.dashboardIcons.menu,
                  height: 24.w,
                ),
              ),
              centerTitle: true,
              title: CustomImageView(
                imagePath: Assets.logo.logoNameBlackIc,
                height: 24.h,
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await getIt<StorageService>().clearTokens();
                    getIt<ProfileCubit>().clearProfile();
                    if (context.mounted) {
                      context.go(AppRoutes.welcome);
                    }
                  },
                  icon: CustomImageView(
                    imagePath: Assets.svgIcons.dashboardIcons.notification,
                    height: 24.w,
                    width: 24.w,
                  ),
                ),
              ],
            ),
            body: IndexedStack(
              index: state.currentIndex,
              children: [
                _buildBody('Home'),
                _buildBody('Discover'),
                _buildBody('Match'),
                _buildBody('Message'),
                _buildBody('Profile'),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: cubit.setTab,
              type: .fixed,
              backgroundColor: AppColors.whiteColor,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: AppColors.textLightColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                _buildNavItem(
                  Assets.svgIcons.dashboardIcons.home,
                  Assets.svgIcons.dashboardIcons.homeDark,
                  0,
                  state.currentIndex,
                ),
                _buildNavItem(
                  Assets.svgIcons.dashboardIcons.discover,
                  Assets.svgIcons.dashboardIcons.discoverDark,
                  1,
                  state.currentIndex,
                ),
                _buildNavItem(
                  Assets.svgIcons.dashboardIcons.match,
                  Assets.svgIcons.dashboardIcons.matchDark,
                  2,
                  state.currentIndex,
                ),
                _buildNavItem(
                  Assets.svgIcons.dashboardIcons.message,
                  Assets.svgIcons.dashboardIcons.messageDark,
                  3,
                  state.currentIndex,
                ),
                _buildNavItem(
                  Assets.svgIcons.dashboardIcons.profile,
                  Assets.svgIcons.dashboardIcons.profileDark,
                  4,
                  state.currentIndex,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String icon,
    String activeIcon,
    int index,
    int currentIndex,
  ) {
    final isSelected = index == currentIndex;
    return BottomNavigationBarItem(
      icon: CustomImageView(
        imagePath: isSelected ? activeIcon : icon,
        height: 24.w,
        width: 24.w,
      ),
    );
  }

  Widget _buildBody(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
