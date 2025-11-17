import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/scaffold_foundation/scaffold_foundation_widget.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = getIt<Internationalization>().translate;

    return ScaffoldFoundation(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            CircularProgressIndicator(),
            SpacingFoundation.md.spacer,
            Text(t(Translate.loading)),
          ],
        ),
      ),
    );
  }
}
