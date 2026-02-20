import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_answer_model/compatibility_answer_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/compatibility_ring_model/compatibility_ring_model.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class CompatibilityRingScreenArgs {
  const CompatibilityRingScreenArgs({
    this.compatibilityRing,
    this.queCount,
    this.answeredQue,
    this.compatibilityAnswers,
  });
  final List<CompatibilityRingModel>? compatibilityRing;
  final int? queCount;
  final int? answeredQue;
  final List<CompatibilityAnswerModel>? compatibilityAnswers;
}

class CompatibilityRingScreen extends StatelessWidget {
  const CompatibilityRingScreen({super.key, this.args});

  final CompatibilityRingScreenArgs? args;

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      header: context.l10n.buildCompatibilityRing,
      subText: context.l10n.optionalQuestionsForBetterMatches,
      subTextTopPad: 8.h,
      btmWidget: Column(
        mainAxisSize: .min,
        children: [
          CommonBtn(
            title: context.l10n.startCompatibilityQuestions,
            onTap: () => context.pushNamed(
              AppRoutes.compatibilityQuestions,
              extra: args,
            ),
          ),
          Padding(
            padding: 12.vertPad,
            child: CommonBtn(
              title: context.l10n.skipForNow,
              btnColor: AppColors.transparent,
              borderColor: AppColors.primaryColor,
              txtColor: AppColors.primaryColor,
              onTap: () => context.go(AppRoutes.dashboard),
            ),
          ),
          Text(
            context.l10n.youCanComeBackThisAnytime,
            style: AppTextStyle.s12w400(color: AppColors.textPrimaryColor),
          ),
        ],
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 60.h),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(200.w, 200.w),
                  painter: RingPainter(
                    ringColor: AppColors.blackColor.withValues(alpha: 0.1),
                    dotColor: AppColors.primaryColor,
                    strokeWidth: 17.w,
                    progress: (args?.answeredQue ?? 0) / (args?.queCount ?? 1),
                    progressColor: AppColors.primaryColor,
                  ),
                ),
                RichText(
                  textAlign: .center,
                  text: TextSpan(
                    text: '${context.l10n.findYourMatch}\n',
                    style: AppTextStyle.s20w600(),
                    children: [
                      TextSpan(
                        text: context.l10n.match,
                        style: AppTextStyle.s35w400(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// class RingPainter extends CustomPainter {
//   RingPainter({
//     required this.ringColor,
//     required this.dotColor,
//     required this.strokeWidth,
//   });

//   final Color ringColor;
//   final Color dotColor;
//   final double strokeWidth;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = (size.width - strokeWidth) / 2;

//     final ringPaint = Paint()
//       ..color = ringColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     canvas.drawCircle(center, radius, ringPaint);

//     final dotPaint = Paint()..color = dotColor;
//     canvas.drawCircle(Offset(size.width / 2, strokeWidth / 2), 10.w, dotPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class RingPainter extends CustomPainter {
  RingPainter({
    required this.ringColor,
    required this.progressColor,
    required this.dotColor,
    required this.strokeWidth,
    required this.progress, // 0.0 to 1.0
  });

  final Color ringColor;
  final Color progressColor;
  final Color dotColor;
  final double strokeWidth;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background ring (full circle)
    final ringPaint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, ringPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from top (-90 degrees = -π/2 radians)
    // Sweep angle based on progress (360 degrees = 2π radians)
    final sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );

    // Dot at the end of progress
    // if (progress > 0) {
    // Calculate dot position based on progress
    final angle = -pi / 2 + sweepAngle;
    final dotX = center.dx + radius * cos(angle);
    final dotY = center.dy + radius * sin(angle);

    final dotPaint = Paint()..color = dotColor;
    canvas.drawCircle(Offset(dotX, dotY), 6.w, dotPaint);
    // }
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.ringColor != ringColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.dotColor != dotColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
