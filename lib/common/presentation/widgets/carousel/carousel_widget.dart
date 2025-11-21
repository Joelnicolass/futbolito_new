import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemExtent: MediaQuery.of(context).size.width * 0.8,
        itemBuilder: (context, index) {
          return Card(
            index: index,
            onPressed: () {
              print('Card ${index + 1} pressed');
            },
            header: CardHeader(
              title: 'Card ${index + 1}',
              subtitle: 'Subtitle for card ${index + 1}',
              icon: Icon(Icons.star, color: Colors.amber, size: 32),
            ),
            body: CardBody(
              child: TextFoundation(
                text: 'Custom content here',
                style: TextStyle(fontSize: 12),
              ),
            ),
            footer: CardFooter(
              primaryAction: ButtonFoundation(
                text: 'Primary',
                type: ButtonFoundationType.primary,
                size: ButtonFoundationSize.sm,
                onPressed: () {
                  print('Primary action on Card ${index + 1}');
                },
              ),
              secondaryAction: ButtonFoundation(
                text: 'Secondary',
                type: ButtonFoundationType.secondary,
                size: ButtonFoundationSize.sm,
                onPressed: () {
                  print('Secondary action on Card ${index + 1}');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Compound Component: CardHeader
class CardHeader extends StatelessWidget {
  const CardHeader({super.key, this.title, this.subtitle, this.icon});

  final String? title;
  final String? subtitle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Texto (título y subtítulo)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                TextFoundation(
                  text: title!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              if (subtitle != null) ...[
                SizedBox(height: SpacingFoundation.xs.value),
                TextFoundation(
                  text: subtitle!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
        // Icono a la derecha
        if (icon != null) ...[
          SizedBox(width: SpacingFoundation.sm.value),
          icon!,
        ],
      ],
    );
  }
}

// Compound Component: CardBody
class CardBody extends StatelessWidget {
  const CardBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

// Compound Component: CardFooter
class CardFooter extends StatelessWidget {
  const CardFooter({super.key, this.primaryAction, this.secondaryAction});

  final Widget? primaryAction;
  final Widget? secondaryAction;

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (primaryAction != null) primaryAction!,
      if (secondaryAction != null) secondaryAction!,
    ];

    if (actions.isEmpty) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (primaryAction != null)
          Expanded(child: primaryAction!)
        else
          Spacer(),
        if (primaryAction != null && secondaryAction != null)
          SizedBox(width: SpacingFoundation.sm.value),
        if (secondaryAction != null) Expanded(child: secondaryAction!),
      ],
    );
  }
}

// Main Card Component
class Card extends StatelessWidget {
  const Card({
    super.key,
    this.index = 0,
    this.onPressed,
    this.header,
    this.body,
    this.footer,
    this.height,
    this.width,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
  });

  final int index;
  final VoidCallback? onPressed;
  final CardHeader? header;
  final CardBody? body;
  final CardFooter? footer;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: 100 * index),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: PaddingFoundation.md.value,
          top: PaddingFoundation.md.value,
          left: index == 0 ? PaddingFoundation.md.value : 0,
          right: index == 9 ? PaddingFoundation.md.value : 0,
        ),
        child: GestureDetector(
          onTap: () => onPressed?.call(),
          child: Container(
            height: height,
            width: width ?? 200,
            padding: padding ?? EdgeInsets.all(PaddingFoundation.md.value),
            decoration: BoxDecoration(
              color: backgroundColor ?? ColorFoundation.cardBackground.color,
              boxShadow:
                  boxShadow ??
                  [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
              borderRadius: borderRadius ?? BorderRadius.circular(25),
            ),
            margin: SpacingFoundation.xs.all,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                if (header != null) ...[
                  header!,
                  SizedBox(height: SpacingFoundation.md.value),
                ],
                // Body Section
                if (body != null) ...[
                  Expanded(child: body!),
                  SizedBox(height: SpacingFoundation.md.value),
                ],
                // Footer Section
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
