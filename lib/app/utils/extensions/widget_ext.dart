import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

extension WidgetExt on Widget {
  Hero hero({required String tag}) => Hero(
    tag: tag,
    child: Material(type: MaterialType.transparency, child: this),
  );

  Shimmer shimmer() => Shimmer(child: this);

  SmartRefresher smartRefresh({
    required RefreshController controller,
    bool enablePullDown = true,
    bool enablePullUp = false,
    Future<void> Function()? onRefresh,
    Future<void> Function()? onLoading,
  }) => SmartRefresher(
    controller: controller,
    physics: const ClampingScrollPhysics(),
    onRefresh: () async {
      await onRefresh?.call();
      controller.refreshCompleted();
    },
    onLoading: () async {
      await onLoading?.call();
      controller.loadComplete();
    },
    enablePullDown: enablePullDown,
    enablePullUp: enablePullUp,
    child: this,
  );
}
