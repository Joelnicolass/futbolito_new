import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SkeletonFoundation extends StatelessWidget {
  const SkeletonFoundation({
    super.key,
    this.width,
    this.height,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white70,
    this.shape,
    this.radius,
  });

  final double? width;
  final double? height;
  final Color baseColor;
  final Color highlightColor;
  final BoxShape? shape;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          shape: shape ?? BoxShape.rectangle,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(radius ?? 8)
              : null,
        ),
      ),
    );
  }
}
