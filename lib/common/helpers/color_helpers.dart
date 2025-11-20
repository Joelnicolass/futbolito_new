import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';

final colors = [
  ColorFoundation.primary.color.withValues(alpha: 200, green: 100),
  ColorFoundation.secondary.color.withValues(alpha: 200, red: 100),
  ColorFoundation.tertiary.color.withValues(alpha: 200, blue: 100),
  ColorFoundation.info.color.withValues(alpha: 200, blue: 150),
  ColorFoundation.success.color.withValues(alpha: 200, green: 150),
  ColorFoundation.warning.color.withValues(alpha: 200, red: 150, green: 150),
  ColorFoundation.error.color.withValues(alpha: 200, red: 150, green: 150),
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
