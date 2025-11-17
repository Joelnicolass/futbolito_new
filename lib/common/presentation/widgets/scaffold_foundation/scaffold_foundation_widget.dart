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
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        colors: [
          ...(gradientColors ??
              [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface,
              ]),
        ],
        child: SafeArea(
          child: FadeIn(
            child: Column(
              children: [
                if (appBar != null) appBar!,
                Expanded(
                  child: Padding(
                    padding: PaddingFoundation.medium.all,
                    child: body,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
