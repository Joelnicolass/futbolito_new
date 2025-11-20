import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text.dart';
import 'package:futbolitonew/core/intl/intl.dart';

enum ButtonFoundationType {
  primary,
  secondary,
  outlined,
  text,
  link,
  alternative,
}

enum ButtonFoundationSize { sm, md, lg }

class ButtonFoundation extends StatelessWidget {
  const ButtonFoundation({
    super.key,
    this.text,
    this.type = ButtonFoundationType.primary,
    this.size = ButtonFoundationSize.md,
    this.textKey,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.iconSpacing,
  });

  final String? text;
  final ButtonFoundationType type;
  final ButtonFoundationSize size;
  final VoidCallback? onPressed;
  final Translate? textKey;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final double? width;
  final double? height;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? iconSpacing;

  static final Map<ButtonFoundationType, _ButtonStyleConfig> _typeStyles = {
    ButtonFoundationType.primary: _ButtonStyleConfig(
      backgroundColor: ColorFoundation.primary.color,
      textColor: ColorFoundation.white.color,
    ),
    ButtonFoundationType.secondary: _ButtonStyleConfig(
      backgroundColor: ColorFoundation.secondary.color,
      textColor: ColorFoundation.white.color,
    ),
    ButtonFoundationType.outlined: _ButtonStyleConfig(
      backgroundColor: Colors.transparent,
      textColor: ColorFoundation.primary.color,
      borderColor: ColorFoundation.primary.color,
    ),
    ButtonFoundationType.text: _ButtonStyleConfig(
      backgroundColor: Colors.transparent,
      textColor: ColorFoundation.primary.color,
    ),
    ButtonFoundationType.link: _ButtonStyleConfig(
      backgroundColor: Colors.transparent,
      textColor: ColorFoundation.textPrimary.color,
      underline: true,
    ),
    ButtonFoundationType.alternative: _ButtonStyleConfig(
      backgroundColor: ColorFoundation.tertiary.color,
      textColor: ColorFoundation.dark.color,
    ),
  };

  static final Map<ButtonFoundationSize, _ButtonSizeConfig> _sizeConfigs = {
    ButtonFoundationSize.sm: _ButtonSizeConfig(
      fontSize: 14,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: 100,
      minHeight: 32,
    ),
    ButtonFoundationSize.md: _ButtonSizeConfig(
      fontSize: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 100,
      minHeight: 44,
    ),
    ButtonFoundationSize.lg: _ButtonSizeConfig(
      fontSize: 18,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 100,
      minHeight: 56,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final text = textKey != null ? textKey!.toTextFoundation().text : this.text;

    final styleConfig = _typeStyles[type]!;
    final sizeConfig = _sizeConfigs[size]!;

    final effectiveBackgroundColor =
        backgroundColor ?? styleConfig.backgroundColor;

    final effectiveTextColor = textColor ?? styleConfig.textColor;

    final effectiveBorderColor = borderColor ?? styleConfig.borderColor;

    final effectivePadding = padding ?? sizeConfig.padding;

    final effectiveBorderRadius =
        borderRadius ??
        BorderRadius.all(Radius.circular(sizeConfig.borderRadius));

    final effectiveTextStyle = (textStyle ?? TextStyle()).copyWith(
      color: effectiveTextColor,
      fontSize: textStyle?.fontSize ?? sizeConfig.fontSize,
      decoration: styleConfig.underline ? TextDecoration.underline : null,
    );

    final buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (prefixIcon != null) prefixIcon!,
        if (prefixIcon != null && text != null)
          SizedBox(width: iconSpacing ?? 8),
        TextFoundation(text: text ?? '', style: effectiveTextStyle),
        if (suffixIcon != null && text != null)
          SizedBox(width: iconSpacing ?? 8),
        if (suffixIcon != null) suffixIcon!,
      ],
    );

    Widget button = _buildButtonByType(
      styleConfig: styleConfig,
      effectiveBackgroundColor: effectiveBackgroundColor,
      effectiveTextColor: effectiveTextColor,
      effectiveBorderColor: effectiveBorderColor,
      effectivePadding: effectivePadding,
      effectiveBorderRadius: effectiveBorderRadius,
      buttonContent: buttonContent,
      sizeConfig: sizeConfig,
    );

    if (width != null || height != null)
      button = SizedBox(width: width, height: height, child: button);

    return button;
  }

  Widget _buildButtonByType({
    required _ButtonStyleConfig styleConfig,
    required Color effectiveBackgroundColor,
    required Color effectiveTextColor,
    required Color? effectiveBorderColor,
    required EdgeInsetsGeometry effectivePadding,
    required BorderRadius effectiveBorderRadius,
    required Widget buttonContent,
    required _ButtonSizeConfig sizeConfig,
  }) {
    final shape = RoundedRectangleBorder(borderRadius: effectiveBorderRadius);

    switch (type) {
      case ButtonFoundationType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: effectiveTextColor,
            padding: effectivePadding,
            shape: shape,
            side: effectiveBorderColor != null
                ? BorderSide(color: effectiveBorderColor, width: 1.5)
                : BorderSide(color: effectiveTextColor, width: 1.5),
            minimumSize: Size.fromHeight(sizeConfig.minHeight),
          ),
          child: buttonContent,
        );

      case ButtonFoundationType.text:
      case ButtonFoundationType.link:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: effectiveTextColor,
            padding: effectivePadding,
            shape: shape,
            minimumSize: Size.fromHeight(sizeConfig.minHeight),
          ),
          child: buttonContent,
        );

      case ButtonFoundationType.primary:
      case ButtonFoundationType.secondary:
      case ButtonFoundationType.alternative:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: effectiveBackgroundColor,
            padding: effectivePadding,
            shape: shape,
            minimumSize: Size.fromHeight(sizeConfig.minHeight),
          ),
          child: buttonContent,
        );
    }
  }
}

class _ButtonStyleConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final bool underline;

  _ButtonStyleConfig({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.underline = false,
  });
}

class _ButtonSizeConfig {
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double minHeight;

  _ButtonSizeConfig({
    required this.fontSize,
    required this.padding,
    required this.borderRadius,
    required this.minHeight,
  });
}

extension StringButtonFoundationExtension on String {
  ButtonFoundation toButtonFoundation({
    ButtonFoundationType type = ButtonFoundationType.primary,
    ButtonFoundationSize size = ButtonFoundationSize.md,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    double? iconSpacing,
  }) {
    return ButtonFoundation(
      text: this,
      type: type,
      size: size,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      iconSpacing: iconSpacing,
    );
  }
}

extension TranslateButtonFoundationExtension on Translate {
  ButtonFoundation toButtonFoundation({
    ButtonFoundationType type = ButtonFoundationType.primary,
    ButtonFoundationSize size = ButtonFoundationSize.md,
    VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    TextStyle? textStyle,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    double? iconSpacing,
  }) {
    return ButtonFoundation(
      textKey: this,
      type: type,
      size: size,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      padding: padding,
      borderRadius: borderRadius,
      textStyle: textStyle,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      iconSpacing: iconSpacing,
    );
  }
}
