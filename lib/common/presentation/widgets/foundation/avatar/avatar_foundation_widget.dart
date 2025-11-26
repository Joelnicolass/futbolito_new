import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/helpers/color_helpers.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/skeleton/skeleton_foundation_widget.dart';

class AvatarFoundation extends StatelessWidget {
  const AvatarFoundation({
    super.key,
    this.imageUrl,
    this.radius = 30.0,
    this.fallbackText,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2.0,
    this.showBorder = false,
    this.isLoading = false,
  });

  final String? imageUrl;
  final double radius;
  final String? fallbackText;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool showBorder;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final Widget content = switch ((
      isLoading: isLoading,
      hasImage: imageUrl != null && imageUrl!.isNotEmpty,
      hasText: fallbackText != null && fallbackText!.isNotEmpty,
    )) {
      (isLoading: true, hasImage: _, hasText: _) => _AvatarLoading(
        radius: radius,
      ),
      (isLoading: false, hasImage: true, hasText: _) => _AvatarImage(
        imageUrl: imageUrl!,
        radius: radius,
      ),
      (isLoading: false, hasImage: false, hasText: true) => _AvatarText(
        text: fallbackText!,
        radius: radius,
      ),
      _ => _AvatarDefault(radius: radius),
    };

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor:
          backgroundColor ?? ColorHelpers.getRandomColorFromHash(fallbackText),
      child: content,
    );

    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
            width: borderWidth,
          ),
        ),
        child: avatar,
      );
    }

    return avatar;
  }
}

class _AvatarLoading extends StatelessWidget {
  const _AvatarLoading({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return SkeletonFoundation(
      shape: BoxShape.circle,
      width: radius * 2,
      height: radius * 2,
      baseColor: Theme.of(context).colorScheme.primary,
    );
  }
}

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({required this.imageUrl, required this.radius});

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty || imageUrl == 'file:///')
      return _AvatarDefault(radius: radius);

    return ClipOval(
      child: Image.network(
        imageUrl,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _AvatarLoading(radius: radius);
        },
        errorBuilder: (context, error, stackTrace) =>
            _AvatarDefault(radius: radius),
      ),
    );
  }
}

class _AvatarText extends StatelessWidget {
  const _AvatarText({required this.text, required this.radius});

  final String text;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Text(
      _getInitials(text),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: radius * 0.6,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');

    if (parts.isEmpty || parts[0].isEmpty) return '';

    if (parts.length == 1) return parts[0][0].toUpperCase();

    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }
}

class _AvatarDefault extends StatelessWidget {
  const _AvatarDefault({required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: radius,
      color: ColorFoundation.primary.color,
    );
  }
}
