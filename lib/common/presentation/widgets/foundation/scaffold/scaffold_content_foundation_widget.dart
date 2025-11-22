import 'package:animate_do/animate_do.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScaffoldContent extends StatelessWidget {
  const ScaffoldContent({
    super.key,
    required this.child,
    this.onRefresh,
    this.applyOpacityInRefresh = true,
    this.padding,
    this.withAnimation = true,
  });

  final Widget child;
  final Future<void> Function()? onRefresh;
  final bool applyOpacityInRefresh;
  final EdgeInsets? padding;
  final bool withAnimation;

  @override
  Widget build(BuildContext context) {
    const double indicatorSize = 36.0;
    const double indicatorSpacing = 16.0;
    final double pullDistance = indicatorSize + indicatorSpacing;
    // Offset to hide the indicator initially when pulling to refresh
    final double hiddenOffset = defaultTargetPlatform == TargetPlatform.android
        ? indicatorSize + 12.0
        : indicatorSize;

    // Scrollable content
    Widget scrollableContent = LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight.isFinite
                  ? constraints.maxHeight
                  : MediaQuery.of(context).size.height,
            ),
            child: child,
          ),
        );
      },
    );

    // Animation
    if (withAnimation) scrollableContent = FadeIn(child: scrollableContent);

    // Pull-to-refresh
    if (onRefresh != null) {
      return CustomRefreshIndicator(
        builder: (context, child, controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -hiddenOffset + (controller.value * pullDistance),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                  Transform.translate(
                    offset: Offset(0, controller.value * pullDistance),
                    child: Opacity(
                      opacity: (1.0 - controller.value).clamp(
                        applyOpacityInRefresh ? 0.5 : 1.0,
                        1.0,
                      ),
                      child: child,
                    ),
                  ),
                ],
              );
            },
          );
        },
        onRefresh: onRefresh!,
        child: scrollableContent,
      );
    }

    return scrollableContent;
  }
}
