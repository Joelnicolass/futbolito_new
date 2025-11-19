enum TextStyleFoundation { xs, sm, md, lg, xl }

extension TextStyleExtension on TextStyleFoundation {
  double get value {
    switch (this) {
      case TextStyleFoundation.xs:
        return 12.0;
      case TextStyleFoundation.sm:
        return 14.0;
      case TextStyleFoundation.md:
        return 16.0;
      case TextStyleFoundation.lg:
        return 20.0;
      case TextStyleFoundation.xl:
        return 24.0;
    }
  }
}
