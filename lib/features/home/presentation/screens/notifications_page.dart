import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldContent(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SpacingFoundation.md.value,
        children: [],
      ),
    );
  }
}
