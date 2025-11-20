import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextFoundationType { headline1, headline2, bodyText1, bodyText2, caption }

class TextType {
  static const String headline1 = 'headline1';
  static const String headline2 = 'headline2';
  static const String bodyText1 = 'bodyText1';
  static const String bodyText2 = 'bodyText2';
  static const String caption = 'caption';
}

class TextFoundation extends StatelessWidget {
  TextFoundation({
    super.key,
    this.text,
    this.style,
    this.keyText,
    this.type,
    this.align,
  });

  final t = getIt<Internationalization>().translate;

  final String? text;
  final TextStyle? style;
  final Translate? keyText;
  final String? type;
  final TextAlign? align;

  final Map<String, TextStyle> _textStyles = {
    TextType.headline1: GoogleFonts.quicksand(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: ColorFoundation.textPrimary.color,
    ),
    TextType.headline2: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: ColorFoundation.textPrimary.color,
    ),
    TextType.bodyText1: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: ColorFoundation.textPrimary.color,
    ),
    TextType.bodyText2: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ColorFoundation.textPrimaryLight.color,
    ),
    TextType.caption: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: ColorFoundation.textPrimaryLight.color,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final textToShow = keyText != null ? t(keyText!) : text;

    return Text(
      textToShow ?? '',
      style: GoogleFonts.quicksand(textStyle: style ?? _textStyles[type]),
      textAlign: align,
    );
  }
}

extension StringTextFoundationExtension on String {
  TextFoundation toTextFoundation({
    TextStyle? style,
    String? type,
    TextAlign? align,
  }) {
    return TextFoundation(text: this, style: style, type: type);
  }
}

extension TranslateTextFoundationExtension on Translate {
  TextFoundation toTextFoundation({
    TextStyle? style,
    String? type,
    TextAlign? align,
  }) {
    return TextFoundation(
      keyText: this,
      style: style,
      type: type ?? TextType.bodyText1,
      align: align,
    );
  }
}

extension TranslateTextFoundationStringExtension on Translate {
  String toTextFoundationString() {
    final t = getIt<Internationalization>().translate;
    return t(this);
  }
}

extension TextExtensionFoundation on Text {
  TextFoundation toTextFoundation({
    TextStyle? style,
    String? type,
    TextAlign? align,
  }) {
    return TextFoundation(
      text: data,
      style: style ?? this.style,
      type: type,
      align: align,
    );
  }
}
