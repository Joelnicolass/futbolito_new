// Compound Component: CardHeader
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';

// Main Card Component
class CardFoundation extends StatelessWidget {
  const CardFoundation({
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
  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              body!,
              SizedBox(height: SpacingFoundation.md.value),
            ],
            // Footer Section
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}
