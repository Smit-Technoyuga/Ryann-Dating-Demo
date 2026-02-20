import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/extensions/widget_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';

class QuestionShimmer extends StatelessWidget {
  const QuestionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 24.horPad.add(18.vertPad),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Container(
            height: 22,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: 5.radius,
              color: AppColors.shimmerColor,
            ),
            margin: 8.topPad.add(24.btmPad),
          ).shimmer(),
          Container(
            height: 12,
            decoration: BoxDecoration(
              borderRadius: 3.radius,
              color: AppColors.shimmerColor,
            ),
            margin: 8.btmPad,
          ).shimmer(),
          Container(
            height: 12,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: 3.radius,
              color: AppColors.shimmerColor,
            ),
            margin: 18.btmPad,
          ).shimmer(),
          ...List.generate(
            5,
            (index) => Padding(
              padding: 16.btmPad,
              child: Row(
                spacing: 12,
                children: [
                  const CircleAvatar(
                    radius: 9,
                    backgroundColor: AppColors.shimmerColor,
                  ).shimmer(),
                  Container(
                    height: 14,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: 3.radius,
                      color: AppColors.shimmerColor,
                    ),
                  ).shimmer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
