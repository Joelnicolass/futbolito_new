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
        children: [HeaderSection(), const Carousel()],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingFoundation.md.horizontal,
      child: Column(
        spacing: SpacingFoundation.sm.value,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SpacingFoundation.lg.spacer,
          Translate.homeWelcome.toTextFoundation(type: TextType.bodyText1),
          Translate.homeDescription.toTextFoundation(type: TextType.bodyText2),
        ],
      ),
    );
  }
}
