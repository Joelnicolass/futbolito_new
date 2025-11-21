import 'package:animate_do/animate_do.dart';
import 'package:animated_gradient_background/animated_gradient_background.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';

class ScaffoldFoundation extends StatelessWidget {
  const ScaffoldFoundation({
    super.key,
    required this.body,
    this.appBar,
    this.gradientColors,
    this.padding,
    this.useSafeArea = true,
    this.useAnimation = true,
    this.useSliverFillRemaining = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.onRefresh,
    this.applyOpacityInRefresh = false,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Color>? gradientColors;
  final EdgeInsets? padding;
  final bool useSafeArea;
  final bool useAnimation;
  final bool useSliverFillRemaining;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Future<void> Function()? onRefresh;
  final bool applyOpacityInRefresh;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? PaddingFoundation.md.all;
    final safeAreaPadding = useSafeArea
        ? MediaQuery.of(context).padding
        : EdgeInsets.zero;

    // Combinar padding del scaffold con el SafeArea
    final totalPadding = EdgeInsets.only(
      top: effectivePadding.top + safeAreaPadding.top,
      bottom: effectivePadding.bottom + safeAreaPadding.bottom,
      left: effectivePadding.left + safeAreaPadding.left,
      right: effectivePadding.right + safeAreaPadding.right,
    );

    // Contenido scrollable con CustomScrollView para spaceBetween
    Widget content = useSliverFillRemaining
        ? CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: totalPadding,
                sliver: SliverFillRemaining(hasScrollBody: false, child: body),
              ),
            ],
          )
        : SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: totalPadding,
            child: body,
          );

    // Aplicar animación
    if (useAnimation) content = FadeIn(child: content);

    // Pull-to-refresh
    if (onRefresh != null) {
      const double indicatorSize = 36.0;
      const double indicatorSpacing = 16.0;
      final double pullDistance = indicatorSize + indicatorSpacing;
      // Offset adicional solo para Android
      final double hiddenOffset =
          defaultTargetPlatform == TargetPlatform.android
          ? indicatorSize + 12.0
          : indicatorSize;

      content = CustomRefreshIndicator(
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
        child: Container(child: content),
      );
    }

    // Fondo (sin SafeArea que limite el scroll)
    if (gradientColors != null && gradientColors!.isNotEmpty) {
      content = AnimatedGradientBackground(
        colors: gradientColors!,
        child: content,
      );
    } else {
      content = Container(
        width: double.infinity,
        height: double.infinity,
        color:
            backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
        child: content,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

class ScreenAvailableHeight {
  static double calculate(
    BuildContext context, {
    double additionalSubtract = 0.0,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = MediaQuery.of(context).padding;

    final availableHeight =
        screenHeight -
        padding.top -
        padding.bottom -
        (PaddingFoundation.md.all.vertical) -
        additionalSubtract;
    return availableHeight;
  }
}
