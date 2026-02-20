import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/extensions/widget_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';

class CountryListShimmer extends StatelessWidget {
  const CountryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        10,
        (index) => Row(
          spacing: 10.w,
          children: [
            const CircleAvatar(
              radius: 10,
              backgroundColor: AppColors.shimmerColor,
            ),
            Expanded(
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: 5.radius,
                  color: AppColors.shimmerColor,
                ),
                margin: 8.vertPad,
              ),
            ),
          ],
        ).shimmer(),
      ),
    );
  }
}
