import 'package:animate_do/animate_do.dart';
import 'package:animated_gradient_background/animated_gradient_background.dart';
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
              padding: padding ?? PaddingFoundation.medium.all,
              child: body,
            ),
          ),
        ],
      );
    } else {
      content = Column(
        children: [
          if (appBar != null) appBar!,
          Expanded(
            child: Padding(
              padding: padding ?? PaddingFoundation.medium.all,
              child: body,
            ),
          ),
        ],
      );
    }

    // Aplicar animación si está habilitada
    if (useAnimation) content = FadeIn(child: content);

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
