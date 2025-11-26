import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldContent(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [CircularProgressIndicator.adaptive()],
          ),
        ),
      ),
    );
  }
}
