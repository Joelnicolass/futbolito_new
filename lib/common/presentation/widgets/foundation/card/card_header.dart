// Compound Component: CardHeader

import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';

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
