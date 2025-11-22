import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';
import 'package:futbolitonew/core/intl/intl.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldContent(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircularProgressIndicator.adaptive(),
              SpacingFoundation.md.spacer,
              Translate.loading.toTextFoundation(type: TextType.headline2),
            ],
          ),
        ),
      ),
    );
  }
}
