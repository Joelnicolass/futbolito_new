import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/colors_foundation_entity.dart';

final colors = [
  ColorsFoundation.primary.color.withValues(alpha: 200, green: 100),
  ColorsFoundation.secondary.color.withValues(alpha: 200, red: 100),
  ColorsFoundation.tertiary.color.withValues(alpha: 200, blue: 100),
  ColorsFoundation.info.color.withValues(alpha: 200, blue: 150),
  ColorsFoundation.success.color.withValues(alpha: 200, green: 150),
  ColorsFoundation.warning.color.withValues(alpha: 200, red: 150, green: 150),
  ColorsFoundation.error.color.withValues(alpha: 200, red: 150, green: 150),
];

class ColorHelpers {
  static Color get randomColor {
    colors.shuffle();
    return colors.first;
  }

  static Color getRandomColorFromHash(String? input) {
    if (input == null || input.isEmpty) return randomColor;

    final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem);

    final index = hash % colors.length;

    return colors[index];
  }
}
