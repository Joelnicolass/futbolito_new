import 'package:flutter/material.dart';

enum PaddingFoundation { small, medium, large }

extension PaddingFoundationExtension on PaddingFoundation {
  double get value {
    switch (this) {
      case PaddingFoundation.small:
        return 8.0;
      case PaddingFoundation.medium:
        return 16.0;
      case PaddingFoundation.large:
        return 24.0;
    }
  }
}

extension PaddingFoundationAllExtension on PaddingFoundation {
  EdgeInsets get all => EdgeInsets.all(value);
  EdgeInsets get left => EdgeInsets.only(left: value);
  EdgeInsets get right => EdgeInsets.only(right: value);
  EdgeInsets get top => EdgeInsets.only(top: value);
  EdgeInsets get bottom => EdgeInsets.only(bottom: value);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: value);
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: value);
}
