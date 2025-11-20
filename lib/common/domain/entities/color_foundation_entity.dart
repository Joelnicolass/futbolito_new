import 'package:flutter/material.dart';

enum ColorFoundation {
  background,
  surface,
  primary,
  primary400,
  primary600,
  primary800,
  secondary,
  secondary400,
  secondary600,
  secondary800,
  tertiary,
  tertiary400,
  tertiary600,
  tertiary800,
  dark,
  white,
  black,
  success,
  warning,
  error,
  info,
  disabled,
  cardBackground,
}

extension ColorFoundationExtension on ColorFoundation {
  String get name {
    switch (this) {
      case ColorFoundation.background:
        return '#FFF8E1';
      case ColorFoundation.surface:
        return '#FFFFFF';
      case ColorFoundation.primary:
        return '#4ECDC4';
      case ColorFoundation.primary400:
        return '#66D6D0';
      case ColorFoundation.primary600:
        return '#3EBAB4';
      case ColorFoundation.primary800:
        return '#2E8F8A';
      case ColorFoundation.secondary:
        return '#FF6B6B';
      case ColorFoundation.secondary400:
        return '#FF8585';
      case ColorFoundation.secondary600:
        return '#E65555';
      case ColorFoundation.secondary800:
        return '#B33E3E';
      case ColorFoundation.tertiary:
        return '#FFD166';
      case ColorFoundation.tertiary400:
        return '#FFDF85';
      case ColorFoundation.tertiary600:
        return '#E6C655';
      case ColorFoundation.tertiary800:
        return '#B39E3E';
      case ColorFoundation.dark:
        return '#292F36';
      case ColorFoundation.white:
        return '#FFFFFF';
      case ColorFoundation.black:
        return '#292F36';
      case ColorFoundation.success:
        return '#28A745';
      case ColorFoundation.warning:
        return '#FFC107';
      case ColorFoundation.error:
        return '#DC3545';
      case ColorFoundation.info:
        return '#17A2B8';
      case ColorFoundation.disabled:
        return '#6C757D';
      case ColorFoundation.cardBackground:
        return '#FFFBF6';
    }
  }
}

extension ColorFoundationHexExtension on ColorFoundation {
  String get hex => name.replaceAll('#', '0xFF');
  Color get color => Color(int.parse(hex));
}
