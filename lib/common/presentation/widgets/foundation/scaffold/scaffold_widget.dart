import 'package:animate_do/animate_do.dart';
import 'package:animated_gradient_background/animated_gradient_background.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
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
    this.enableScroll = true,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.onRefresh,
    this.isLoading = false,
    this.applyOpacityInRefresh = false,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Color>? gradientColors;
  final EdgeInsets? padding;
  final bool useSafeArea;
  final bool useAnimation;
  final bool enableScroll;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final Future<void> Function()? onRefresh;
  final bool isLoading;
  final bool applyOpacityInRefresh;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (enableScroll) {
      content = CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (appBar != null) SliverToBoxAdapter(child: appBar!),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: padding ?? PaddingFoundation.md.all,
              child: body,
            ),
          ),
        ],
      );
    } else {
      content = SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (appBar != null) appBar!,
            Padding(padding: padding ?? PaddingFoundation.md.all, child: body),
          ],
        ),
      );
    }

    // Aplicar animación si está habilitada
    if (useAnimation) content = FadeIn(child: content);

    if (onRefresh != null) {
      const double indicatorSize = 36.0;
      const double indicatorSpacing = 16.0;
      final double pullDistance = indicatorSize + indicatorSpacing;

      content = CustomRefreshIndicator(
        builder: (context, child, controller) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -indicatorSize + (controller.value * pullDistance),
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

    // Aplicar SafeArea si está habilitado
    if (useSafeArea) content = SafeArea(child: content);

    // Aplicar fondo (gradiente o color sólido)
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
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
