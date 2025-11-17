import 'package:flutter/material.dart';

enum SpacingFoundation { xs, sm, md, lg, xl }

extension SpacingExtension on SpacingFoundation {
  double get value {
    switch (this) {
      case SpacingFoundation.xs:
        return 4.0;
      case SpacingFoundation.sm:
        return 8.0;
      case SpacingFoundation.md:
        return 16.0;
      case SpacingFoundation.lg:
        return 24.0;
      case SpacingFoundation.xl:
        return 32.0;
    }
  }
}

extension SpacerExtension on SpacingFoundation {
  SizedBox get spacer => SizedBox(height: value);
}
