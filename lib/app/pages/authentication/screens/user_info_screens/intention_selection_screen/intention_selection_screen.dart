import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class IntentionSelectionScreen extends StatelessWidget {
  const IntentionSelectionScreen({super.key, required this.intentions});
  final List<IntentionModel> intentions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IntentionSelectionCubit(context: context)..setIntentions(intentions),
      child: BlocBuilder<IntentionSelectionCubit, IntentionSelectionState>(
        builder: (context, state) {
          final cubit = context.read<IntentionSelectionCubit>();

          return CommonAuthScreen(
            header: context.l10n.setYourIntention,
            subText: context.l10n.chooseWhatYoureLookingFor,
            subTextTopPad: 8.h,
            btmWidget: Container(
              padding: 12.allPad,
              decoration: BoxDecoration(
                color: AppColors.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                spacing: 12.w,
                children: [
                  CustomImageView(
                    imagePath: Assets.svgIcons.infoIc,
                    height: 20.h,
                    width: 20.w,
                  ),
                  Text(
                    context.l10n.lockedForThirtyDays,
                    style: AppTextStyle.s12w400(
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              Padding(
                padding: 32.topPad.add(16.btmPad),
                child: Text(
                  context.l10n.intentionsList,
                  style: AppTextStyle.s16w500(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              ...List.generate(state.intentions.length, (index) {
                final item = state.intentions[index];
                final isSelected = state.selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    cubit.selectIntention(index);
                    context.push(AppRoutes.intentionConfirmation, extra: cubit);
                  },
                  child: Padding(
                    padding: 12.btmPad,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: .topRight,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 48.w, // Space for icon
                            top: 16.h,
                            bottom: 16.h,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xfffff5f5)
                                : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                            ),
                          ),
                          child: Text(
                            item.label ?? '',
                            style: AppTextStyle.s14w400(
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 6.w,
                          top: 6.w,
                          child: InfoIcon(description: item.description ?? ''),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class InfoIcon extends StatefulWidget {
  const InfoIcon({super.key, required this.description});
  final String description;

  @override
  State<InfoIcon> createState() => _InfoIconState();
}

class _InfoIconState extends State<InfoIcon> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _iconKey = GlobalKey();

  void _showTooltip() {
    final renderBox = _iconKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final iconSize = renderBox.size;
    final iconCenterY = position.dy + iconSize.height / 2;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Tap outside to close
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideTooltip,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          // Tooltip
          _TooltipContent(
            iconCenterY: iconCenterY,
            description: widget.description,
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _iconKey,
      onTap: _showTooltip,
      child: CustomImageView(
        imagePath: Assets.svgIcons.infoIc,
        width: 16.w,
        height: 16.w,
        color: AppColors.textGreyColor,
      ),
    );
  }
}

class _TooltipContent extends StatefulWidget {
  const _TooltipContent({required this.iconCenterY, required this.description});
  final double iconCenterY;
  final String description;

  @override
  State<_TooltipContent> createState() => _TooltipContentState();
}

class _TooltipContentState extends State<_TooltipContent> {
  final GlobalKey _contentKey = GlobalKey();
  double? _tooltipHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && mounted) {
        setState(() {
          _tooltipHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate top position so arrow aligns with icon center
    final topPosition = _tooltipHeight != null
        ? widget.iconCenterY - (_tooltipHeight! / 2)
        : widget.iconCenterY - 40; // Default estimate

    return Positioned(
      right: 40,
      top: topPosition,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: context.width * 0.7),
          key: _contentKey,
          margin: 10.rightPad,
          padding: 8.vertPad.add(12.horPad),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: const TooltipShapeBorder(arrowHeight: 12, radius: 8),
            shadows: [
              BoxShadow(
                color: const Color(0xFF435838).withValues(alpha: 0.22),
                blurRadius: 12,
              ),
            ],
          ),
          child: Text(
            widget.description,
            style: AppTextStyle.s12w400(color: AppColors.textLightColor),
          ),
        ),
      ),
    );
  }
}

class TooltipShapeBorder extends ShapeBorder {
  const TooltipShapeBorder({
    this.arrowWidth = 10.0,
    this.arrowHeight = 10.0,
    this.radius = 4,
  });

  final double arrowWidth;
  final double arrowHeight;
  final double radius;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(right: arrowWidth);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = radius;
    final aw = arrowWidth;
    final ah = arrowHeight;

    final boxWidth = rect.width - aw;

    final path = Path();

    path.moveTo(rect.left + r, rect.top);
    path.lineTo(rect.left + boxWidth - r, rect.top);

    path.arcToPoint(
      Offset(rect.left + boxWidth, rect.top + r),
      radius: Radius.circular(r),
    );

    final arrowStartY = (rect.height - ah) / 2;
    path.lineTo(rect.left + boxWidth, rect.top + arrowStartY);

    path.lineTo(rect.left + boxWidth + aw, rect.top + rect.height / 2);
    path.lineTo(rect.left + boxWidth, rect.top + arrowStartY + ah);

    path.lineTo(rect.left + boxWidth, rect.bottom - r);

    path.arcToPoint(
      Offset(rect.left + boxWidth - r, rect.bottom),
      radius: Radius.circular(r),
    );

    path.lineTo(rect.left + r, rect.bottom);

    path.arcToPoint(
      Offset(rect.left, rect.bottom - r),
      radius: Radius.circular(r),
    );

    path.lineTo(rect.left, rect.top + r);

    path.arcToPoint(
      Offset(rect.left + r, rect.top),
      radius: Radius.circular(r),
    );

    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => TooltipShapeBorder(
    arrowWidth: arrowWidth * t,
    arrowHeight: arrowHeight * t,
    radius: radius * t,
  );
}
