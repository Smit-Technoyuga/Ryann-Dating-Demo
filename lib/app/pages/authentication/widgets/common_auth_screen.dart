import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/extensions/widget_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/status_bar_theme.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class CommonAuthScreen extends StatelessWidget {
  const CommonAuthScreen({
    super.key,
    required this.children,
    this.btmWidget,
    this.header,
    this.subText,
    this.subTextTopPad,
    this.headerStyle,
    this.controller,
    this.onRefresh,
  });
  final List<Widget> children;
  final Widget? btmWidget;
  final String? header;
  final String? subText;
  final double? subTextTopPad;
  final TextStyle? headerStyle;
  final RefreshController? controller;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final child = ListView(
      padding: 24.horPad.add(12.vertPad.add(context.bottomPad.btmPad)),
      children: [
        if (header != null)
          Text(header!, style: headerStyle ?? AppTextStyle.s22w500()),
        if (subText != null)
          Padding(
            padding: (subTextTopPad ?? 12).topPad,
            child: Text(
              subText!,
              style: AppTextStyle.s14w400(color: AppColors.textLightColor),
            ),
          ),
        ...children,
      ],
    );
    return AnnotatedRegion(
      value: StatusBarTheme.darkWhite,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            try {
              context.read<AuthCubit>().cancelRequests();
            } catch (_) {}
            try {
              context.read<ProfileCubit>().cancelRequests();
            } catch (_) {}
            // Add other cubits if they are generally available in the tree
          }
        },
        child: Scaffold(
          bottomNavigationBar: btmWidget != null
              ? Padding(
                  padding: context.bottomPad.btmPad
                      .add(24.horPad)
                      .add(10.topPad),
                  child: btmWidget,
                )
              : null,
          body: Padding(
            padding: (context.topPad + 16).topPad,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: 24.leftPad.add(12.btmPad),
                  child: InkWell(
                    onTap: context.pop,
                    child: CustomImageView(
                      imagePath: Assets.svgIcons.backArrow,
                    ),
                  ).hero(tag: 'back'),
                ),
                Expanded(
                  child: controller != null
                      ? child.smartRefresh(
                          controller: controller!,
                          onRefresh: onRefresh,
                        )
                      : child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
