// Compound Component: CardHeader
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';

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
class CardFooterWithActions extends StatelessWidget {
  const CardFooterWithActions({
    super.key,
    this.primaryAction,
    this.secondaryAction,
  });

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
  final CardFooterWithActions? footer;
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
    );
  }
}
