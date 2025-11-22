import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';

import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/core/intl/intl.dart';

class MatchesPage extends ConsumerWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldContent(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Translate.matchesTitle.toTextFoundation(type: TextType.headline2),
            const SizedBox(height: 8),
            Translate.matchesDescription.toTextFoundation(
              type: TextType.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
