import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>
    with SingleTickerProviderStateMixin {
  CameraController? controller;
  XFile? videoFile;
  bool isRecording = false;
  bool isLoading = false;
  int countdown = 5;
  Timer? countdownTimer;

  late AnimationController _scanController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanAnimation = Tween<double>(begin: 0, end: 1).animate(_scanController);
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      controller = CameraController(
        frontCamera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );
      await controller!.initialize();

      // Set default zoom level
      await controller!.setZoomLevel(1.3);

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint('Camera initialization failed: $e');
    }
  }

  void startCountdown() {
    countdown = 5;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 1) {
        if (mounted) {
          setState(() {
            countdown--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> recordVideo() async {
    if (controller == null || !controller!.value.isInitialized) return;

    try {
      setState(() {
        isRecording = true;
      });

      startCountdown();
      await controller!.startVideoRecording();
      await Future.delayed(const Duration(seconds: 5));
      videoFile = await controller!.stopVideoRecording();

      countdownTimer?.cancel();

      setState(() {
        isRecording = false;
      });

      if (videoFile != null) {
        await uploadVideo();
      }
    } catch (e) {
      countdownTimer?.cancel();
      if (mounted) {
        setState(() {
          isRecording = false;
        });
      }
      _showResponseDialog(null, message: 'Error during recording: $e');
    }
  }

  Future<void> uploadVideo() async {
    if (videoFile == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.65:8000/verify'),
      );

      request.files.add(
        await http.MultipartFile.fromPath('video', videoFile!.path),
      );

      final response = await request.send();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      final bodyString = await response.stream.bytesToString();
      debugPrint('==>> response $bodyString');

      try {
        final body = jsonDecode(bodyString) as Map<String, dynamic>;
        _showResponseDialog(body);
      } catch (e) {
        _showResponseDialog(
          null,
          message: 'Invalid server response: $bodyString',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      _showResponseDialog(null, message: 'Upload failed: $e');
    }
  }

  void _showResponseDialog(Map<String, dynamic>? response, {String? message}) {
    if (!mounted) return;

    var title = 'Verification Failed';
    var content = message ?? 'Face verification failed. Please try again.';
    var icon = Icons.error_outline;
    var iconColor = AppColors.errorColor;
    var isSuccess = false;

    if (response != null) {
      final status = response['status']?.toString().toLowerCase();
      final reason = response['reason']?.toString().toLowerCase();
      final details = response['details'] as Map<String, dynamic>?;

      if (status == 'verified') {
        isSuccess = true;
        title = 'Verified Successfully';
        content = 'Amazing! Your identity has been successfully verified.';
        icon = Icons.check_circle_outline;
        iconColor = AppColors.greenColor;
      } else if (reason == 'insufficient_liveness') {
        title = 'Movement Needed';
        final blinks = (details?['blinks'] as int?) ?? 0;
        content =
            "We couldn't detect enough movement. Please blink naturally and move slightly while recording.";
        if (blinks == 0) {
          content += '\n\nTip: Make sure to blink clearly.';
        }
        icon = Icons.face_retouching_natural;
        iconColor = Colors.orange;
      } else if (reason == 'spoof_detected') {
        title = 'Authenticity Check';
        content =
            'Our system detected an inconsistency. Please ensure you are in a well-lit area and recording yourself live.';
        icon = Icons.security;
        iconColor = AppColors.errorColor;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: 16.radius),
          title: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.s18w600(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            content,
            style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (isSuccess) {
                  // If success, you might want to navigate forward or close the screen
                  // Navigator.pop(context);
                }
              },
              child: Text(
                isSuccess ? 'Continue' : 'Try Again',
                style: AppTextStyle.s14w600(color: AppColors.primaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    _scanController.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      header: 'Photo Verification',
      subText: "Prove you're real with a quick video check",
      btmWidget: CommonBtn(
        title: isRecording
            ? 'Recording... ($countdown)'
            : (isLoading ? 'Verifying...' : 'Start'),
        isLoading: isLoading,
        isDisabled: isRecording || isLoading,
        onTap: recordVideo,
      ),
      children: [
        SizedBox(height: 40.h),
        Center(
          child: Container(
            width: 280.w,
            height: 380.h,
            decoration: BoxDecoration(
              borderRadius: 140.radius,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(
                color: isRecording
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: 140.radius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (controller != null && controller!.value.isInitialized)
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller!.value.previewSize!.height,
                        height: controller!.value.previewSize!.width,
                        child: CameraPreview(controller!),
                      ),
                    )
                  else
                    const Center(child: CircularProgressIndicator()),

                  // Scanner animation (only shown when recording and NOT loading)
                  if (!isLoading)
                    AnimatedBuilder(
                      animation: _scanAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: _scanAnimation.value * 380.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withValues(
                                    alpha: 0.8,
                                  ),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      },
                    ),

                  // Semi-transparent overlay with oval cutout
                  CustomPaint(
                    painter: FaceRecognitionPainter(isRecording: isRecording),
                  ),

                  if (isRecording)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'REC',
                              style: AppTextStyle.s12w400(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Loading/Lock overlay
                  if (isLoading)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Verifying...',
                                style: AppTextStyle.s16w600(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: 16.horPad,
          child: Text(
            'Align your face within the oval frame.\nOnce recording starts, gently move your head and blink naturally for 5 seconds.',
            textAlign: TextAlign.center,
            style: AppTextStyle.s16w500(color: AppColors.textPrimaryColor),
          ),
        ),
      ],
    );
  }
}

class FaceRecognitionPainter extends CustomPainter {
  FaceRecognitionPainter({required this.isRecording});
  final bool isRecording;

  @override
  void paint(Canvas canvas, Size size) {
    // Semi-transparent guide
    final borderPaint = Paint()
      ..color = AppColors.primaryColor.withValues(
        alpha: isRecording ? 0.6 : 0.4,
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw internal guide oval
    canvas.drawOval(
      Rect.fromLTWH(20.w, 30.h, size.width - 40.w, size.height - 60.h),
      borderPaint,
    );

    // Darken outside the oval
    final outerPaint = Paint()..color = Colors.black.withValues(alpha: 0.3);
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(
        Rect.fromLTWH(20.w, 30.h, size.width - 40.w, size.height - 60.h),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, outerPaint);
  }

  @override
  bool shouldRepaint(covariant FaceRecognitionPainter oldDelegate) =>
      oldDelegate.isRecording != isRecording;
}
