import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/carousel/carousel_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/core/intl/intl.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldContent(
      child: Column(
        spacing: SpacingFoundation.md.value,
        children: [
          const Carousel(),
          Padding(
            padding: PaddingFoundation.md.horizontal,
            child: Column(
              spacing: SpacingFoundation.sm.value,
              children: [
                Translate.homeWelcome.toTextFoundation(
                  type: TextType.headline2,
                ),
                Translate.homeDescription.toTextFoundation(
                  type: TextType.bodyText1,
                ),
              ],
            ),
          ),
          const Carousel(),
          const Carousel(),
          const Carousel(),
        ],
      ),
    );
  }
}
