import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_widget.dart';

class ScaffoldContent extends StatelessWidget {
  const ScaffoldContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenAvailableHeight.calculate(context),
      child: child,
    );
  }
}
