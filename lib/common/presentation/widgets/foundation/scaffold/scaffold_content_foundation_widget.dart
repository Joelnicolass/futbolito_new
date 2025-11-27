import 'package:animate_do/animate_do.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScaffoldContent extends StatefulWidget {
  const ScaffoldContent({
    super.key,
    required this.child,
    this.onRefresh,
    this.applyOpacityInRefresh = true,
    this.padding,
    this.withAnimation = true,
    this.useConstrainedBox = true,
  });

  final Widget child;
  final Future<void> Function()? onRefresh;
  final bool applyOpacityInRefresh;
  final EdgeInsets? padding;
  final bool withAnimation;
  final bool useConstrainedBox;

  @override
  State<ScaffoldContent> createState() => _ScaffoldContentState();
}

class _ScaffoldContentState extends State<ScaffoldContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    await widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    const double indicatorSize = 26.0;
    const double indicatorSpacing = 24.0;
    final double pullDistance = indicatorSize + indicatorSpacing;
    // Offset to hide the indicator initially when pulling to refresh
    final double hiddenOffset = defaultTargetPlatform == TargetPlatform.android
        ? indicatorSize + 12.0
        : indicatorSize;

    // Scrollable content
    Widget scrollableContent = LayoutBuilder(
      builder: (context, constraints) {
        final childWidget = widget.useConstrainedBox
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight.isFinite
                      ? constraints.maxHeight
                      : MediaQuery.of(context).size.height,
                ),
                child: widget.child,
              )
            : widget.child;

        return SingleChildScrollView(
          controller: _scrollController,
          physics: defaultTargetPlatform == TargetPlatform.iOS
              ? const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                )
              : const AlwaysScrollableScrollPhysics(),
          padding: widget.padding,
          child: childWidget,
        );
      },
    );

    // Animation
    if (widget.withAnimation)
      scrollableContent = FadeIn(child: scrollableContent);

    // Pull-to-refresh
    if (widget.onRefresh != null) {
      return CustomRefreshIndicator(
        triggerMode: IndicatorTriggerMode.anywhere,
        builder: (context, child, controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final bool isRefreshing = controller.isLoading;

              final double offset = controller.value * pullDistance;

              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -hiddenOffset + (controller.value * pullDistance),

                    child: const CircularProgressIndicator.adaptive(),
                  ),
                  Transform.translate(
                    offset: Offset(0, offset),
                    child: AbsorbPointer(
                      absorbing: widget.applyOpacityInRefresh && isRefreshing,
                      child: Opacity(
                        opacity: (1.0 - controller.value).clamp(
                          widget.applyOpacityInRefresh ? 0.5 : 1.0,
                          1.0,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onRefresh: _handleRefresh,
        child: scrollableContent,
      );
    }

    return scrollableContent;
  }
}
