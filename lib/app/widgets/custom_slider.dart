import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class CustomRangeSlider extends StatelessWidget {
  const CustomRangeSlider({
    super.key,
    required this.title,
    required this.values,
    required this.onChanged,
    required this.min,
    required this.max,
    this.minLabel,
    this.maxLabel,
  });

  final String title;
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;
  final double min;
  final double max;
  final String? minLabel;
  final String? maxLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.s14w500()),
        Padding(
          padding: 8.topPad.add(16.btmPad),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    minLabel ?? min.toInt().toString(),
                    style: AppTextStyle.s12w400(color: AppColors.textGreyColor),
                  ),
                  Text(
                    maxLabel ?? '${max.toInt()}+',
                    style: AppTextStyle.s12w400(color: AppColors.textGreyColor),
                  ),
                ],
              ),
              _RangeSliderWithTooltip(
                values: values,
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RangeSliderWithTooltip extends StatefulWidget {
  const _RangeSliderWithTooltip({
    required this.values,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final RangeValues values;
  final double min;
  final double max;
  final ValueChanged<RangeValues> onChanged;

  @override
  State<_RangeSliderWithTooltip> createState() =>
      _RangeSliderWithTooltipState();
}

class _RangeSliderWithTooltipState extends State<_RangeSliderWithTooltip> {
  final GlobalKey _tooltipKey = GlobalKey();
  double _tooltipWidth = 60; // Default width
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureTooltipWidth();
    });
  }

  @override
  void didUpdateWidget(_RangeSliderWithTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.values != widget.values) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTooltipWidth();
      });
    }
  }

  void _measureTooltipWidth() {
    final renderBox =
        _tooltipKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _tooltipWidth = renderBox.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final thumbRadius = 8.r;
        final width = constraints.maxWidth - (thumbRadius * 2);
        final startPos =
            ((widget.values.start - widget.min) / (widget.max - widget.min)) *
            width;
        final endPos =
            ((widget.values.end - widget.min) / (widget.max - widget.min)) *
            width;
        final centerPos = (startPos + endPos) / 2 + thumbRadius;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onPanStart: (_) {
                setState(() {
                  _isInteracting = true;
                });
              },
              onPanEnd: (_) {
                setState(() {
                  _isInteracting = false;
                });
              },
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: thumbRadius,
                    elevation: 0,
                    pressedElevation: 0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: AppColors.primaryColor,
                  inactiveTrackColor: AppColors.borderColor,
                  trackHeight: 4.h,
                ),
                child: RangeSlider(
                  values: widget.values,
                  min: widget.min,
                  max: widget.max,
                  onChanged: widget.onChanged,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.borderColor,
                  onChangeStart: (_) {
                    setState(() {
                      _isInteracting = true;
                    });
                  },
                  onChangeEnd: (_) {
                    setState(() {
                      _isInteracting = false;
                    });
                  },
                ),
              ),
            ),
            if (_isInteracting)
              Positioned(
                top: -35.h,
                left: centerPos - (_tooltipWidth / 2),
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _isInteracting ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      key: _tooltipKey,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: ShapeDecoration(
                        shape: const TooltipDownArrowBorder(
                          arrowWidth: 12,
                          arrowHeight: 6,
                          radius: 6,
                        ),
                        color: AppColors.whiteColor,
                        shadows: [
                          BoxShadow(
                            color: AppColors.color454358.withValues(alpha: .12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.values.start.toInt()} - ${widget.values.end.toInt()}',
                        style: AppTextStyle.s12w500(
                          color: AppColors.color525252,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    this.minLabel,
    this.maxLabel,
    this.unit = '',
  });

  final String title;
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final String? minLabel;
  final String? maxLabel;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.s12w500(color: AppColors.textPrimaryColor),
        ),
        Padding(
          padding: 8.topPad.add(16.btmPad),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    minLabel ?? '${min.toInt()} $unit',
                    style: AppTextStyle.s12w400(color: AppColors.textGreyColor),
                  ),
                  Text(
                    maxLabel ?? '${max.toInt()} $unit',
                    style: AppTextStyle.s12w400(color: AppColors.textGreyColor),
                  ),
                ],
              ),
              _SliderWithTooltip(
                value: value,
                min: min,
                max: max,
                unit: unit,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SliderWithTooltip extends StatefulWidget {
  const _SliderWithTooltip({
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  State<_SliderWithTooltip> createState() => _SliderWithTooltipState();
}

class _SliderWithTooltipState extends State<_SliderWithTooltip> {
  final GlobalKey _tooltipKey = GlobalKey();
  double _tooltipWidth = 52; // Default width
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureTooltipWidth();
    });
  }

  @override
  void didUpdateWidget(_SliderWithTooltip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTooltipWidth();
      });
    }
  }

  void _measureTooltipWidth() {
    final renderBox =
        _tooltipKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _tooltipWidth = renderBox.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final thumbRadius = 6.r;
        final trackWidth = width - (thumbRadius * 2);
        final thumbPos =
            ((widget.value - widget.min) / (widget.max - widget.min)) *
                trackWidth +
            thumbRadius;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onPanStart: (_) {
                setState(() {
                  _isInteracting = true;
                });
              },
              onPanEnd: (_) {
                setState(() {
                  _isInteracting = false;
                });
              },
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: thumbRadius,
                    elevation: 0,
                    pressedElevation: 0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: AppColors.primaryColor,
                  inactiveTrackColor: AppColors.borderColor,
                  trackHeight: 6.h,
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  value: widget.value,
                  min: widget.min,
                  max: widget.max,
                  onChanged: widget.onChanged,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.borderColor,
                  onChangeStart: (_) {
                    setState(() {
                      _isInteracting = true;
                    });
                  },
                  onChangeEnd: (_) {
                    setState(() {
                      _isInteracting = false;
                    });
                  },
                ),
              ),
            ),
            if (_isInteracting)
              Positioned(
                top: -35.h,
                left: thumbPos - (_tooltipWidth / 2),
                child: IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _isInteracting ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      key: _tooltipKey,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: ShapeDecoration(
                        shape: const TooltipDownArrowBorder(
                          arrowWidth: 12,
                          arrowHeight: 6,
                          radius: 6,
                        ),
                        color: AppColors.whiteColor,
                        shadows: [
                          BoxShadow(
                            color: AppColors.color454358.withValues(alpha: .12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.value.toInt()} ${widget.unit}',
                        style: AppTextStyle.s12w500(
                          color: AppColors.color525252,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class TooltipDownArrowBorder extends ShapeBorder {
  const TooltipDownArrowBorder({
    this.arrowWidth = 10,
    this.arrowHeight = 7,
    this.radius = 4,
    this.arrowPosition = 0.5, // 0.0 to 1.0, where 0.5 is center
  });

  final double arrowWidth;
  final double arrowHeight;
  final double radius;
  final double arrowPosition; // Position of arrow along bottom edge

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = radius;
    final aw = arrowWidth;
    final ah = arrowHeight;

    // Main box height (excluding arrow)
    final boxHeight = rect.height - ah;

    // Calculate arrow center position on bottom edge
    final arrowCenterX = rect.left + (rect.width * arrowPosition);
    final arrowStartX = arrowCenterX - (aw / 2);
    final arrowEndX = arrowCenterX + (aw / 2);

    final path = Path();

    // Start from top-left corner
    path.moveTo(rect.left + r, rect.top);

    // Top edge
    path.lineTo(rect.right - r, rect.top);

    // Top-right corner
    path.arcToPoint(
      Offset(rect.right, rect.top + r),
      radius: Radius.circular(r),
    );

    // Right edge
    path.lineTo(rect.right, rect.top + boxHeight - r);

    // Bottom-right corner
    path.arcToPoint(
      Offset(rect.right - r, rect.top + boxHeight),
      radius: Radius.circular(r),
    );

    // Bottom edge - right side (before arrow)
    if (arrowEndX < rect.right - r) {
      path.lineTo(arrowEndX, rect.top + boxHeight);
    }

    // Arrow pointing down
    path.lineTo(arrowCenterX, rect.top + boxHeight + ah);
    path.lineTo(arrowStartX, rect.top + boxHeight);

    // Bottom edge - left side (after arrow)
    if (arrowStartX > rect.left + r) {
      path.lineTo(rect.left + r, rect.top + boxHeight);
    }

    // Bottom-left corner
    path.arcToPoint(
      Offset(rect.left, rect.top + boxHeight - r),
      radius: Radius.circular(r),
    );

    // Left edge
    path.lineTo(rect.left, rect.top + r);

    // Top-left corner
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
  ShapeBorder scale(double t) => TooltipDownArrowBorder(
    arrowWidth: arrowWidth * t,
    arrowHeight: arrowHeight * t,
    radius: radius * t,
    arrowPosition: arrowPosition,
  );
}
