import 'package:flutter/material.dart';

enum ColorsFoundation {
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
}

extension ColorsFoundationExtension on ColorsFoundation {
  String get name {
    switch (this) {
      case ColorsFoundation.background:
        return '#FFF8E1';
      case ColorsFoundation.surface:
        return '#FFFFFF';
      case ColorsFoundation.primary:
        return '#4ECDC4';
      case ColorsFoundation.primary400:
        return '#66D6D0';
      case ColorsFoundation.primary600:
        return '#3EBAB4';
      case ColorsFoundation.primary800:
        return '#2E8F8A';
      case ColorsFoundation.secondary:
        return '#FF6B6B';
      case ColorsFoundation.secondary400:
        return '#FF8585';
      case ColorsFoundation.secondary600:
        return '#E65555';
      case ColorsFoundation.secondary800:
        return '#B33E3E';
      case ColorsFoundation.tertiary:
        return '#FFD166';
      case ColorsFoundation.tertiary400:
        return '#FFDF85';
      case ColorsFoundation.tertiary600:
        return '#E6C655';
      case ColorsFoundation.tertiary800:
        return '#B39E3E';
      case ColorsFoundation.dark:
        return '#292F36';
      case ColorsFoundation.white:
        return '#FFFFFF';
      case ColorsFoundation.black:
        return '#292F36';
      case ColorsFoundation.success:
        return '#28A745';
      case ColorsFoundation.warning:
        return '#FFC107';
      case ColorsFoundation.error:
        return '#DC3545';
      case ColorsFoundation.info:
        return '#17A2B8';
      case ColorsFoundation.disabled:
        return '#6C757D';
    }
  }
}

extension ColorsFoundationHexExtension on ColorsFoundation {
  String get hex => name.replaceAll('#', '0xFF');
  Color get color => Color(int.parse(hex));
}
