import 'package:flutter/material.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class RotatingLoadingIcon extends StatefulWidget {
  const RotatingLoadingIcon({super.key, this.size});

  final double? size;

  @override
  State<RotatingLoadingIcon> createState() => _RotatingLoadingIconState();
}

class _RotatingLoadingIconState extends State<RotatingLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: CustomImageView(
        imagePath: Assets.svgIcons.btnLoadingIc,
        height: widget.size,
        width: widget.size,
      ),
    );
  }
}
