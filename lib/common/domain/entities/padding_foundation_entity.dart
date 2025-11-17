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
