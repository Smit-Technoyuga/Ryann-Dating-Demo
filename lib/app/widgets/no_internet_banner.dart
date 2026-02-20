import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/connectivity_service.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/logger.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class NoInternetBanner extends StatefulWidget {
  const NoInternetBanner({super.key, required this.child});
  final Widget child;

  @override
  State<NoInternetBanner> createState() => _NoInternetBannerState();
}

class _NoInternetBannerState extends State<NoInternetBanner>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  late AnimationController _blinkController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _marginAnimation;

  StreamSubscription<void>? _blinkSubscription;
  final ConnectivityService _connectivityService = getIt<ConnectivityService>();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _marginAnimation = Tween<double>(begin: 0, end: 50).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: AppColors.errorColor,
      end: Colors.white.withValues(alpha: .8),
    ).animate(_blinkController);

    _connectivityService.isOnline.addListener(_onConnectivityChanged);
    _blinkSubscription = _connectivityService.onBlinkTriggered.listen((_) {
      'NoInternetBanner received blink trigger'.log;
      _triggerBlink();
    });

    // Set initial state
    if (!_connectivityService.isOnline.value) {
      _animationController.forward();
    }
  }

  void _onConnectivityChanged() {
    if (_connectivityService.isOnline.value) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  void _triggerBlink() {
    if (_blinkController.isAnimating) return;
    _blinkController.forward().then((_) {
      _blinkController.reverse().then((_) {
        _blinkController.forward().then((_) {
          _blinkController.reverse().then((_) {
            // _blinkController.forward().then((_) {
            //   _blinkController.reverse();
            // });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _connectivityService.isOnline.removeListener(_onConnectivityChanged);
    _blinkSubscription?.cancel();
    _animationController.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Builder(
        //   builder: (context) {
        //     return widget.child;
        //   },
        // ),
        ValueListenableBuilder(
          valueListenable: _marginAnimation,
          builder: (context, value, child) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 150),
              bottom: value,
              top: 0,
              left: 0,
              right: 0,
              child: widget.child,
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: _offsetAnimation,
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Material(
                  color: _colorAnimation.value,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ).add((context.bottomPad - 10).btmPad),
                    child: Row(
                      mainAxisAlignment: .center,
                      spacing: 8,
                      children: [
                        Icon(Icons.wifi_off, color: Colors.white, size: 18.sp),
                        Text(
                          'No Internet Connection',
                          style: AppTextStyle.s14w400(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
