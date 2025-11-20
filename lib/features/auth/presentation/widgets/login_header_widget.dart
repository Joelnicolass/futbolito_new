import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text.dart';
import 'package:futbolitonew/core/intl/intl.dart';

/// Widget del encabezado del login (logo y textos)
class LoginHeader extends StatelessWidget {
  const LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          from: 20,
          duration: const Duration(milliseconds: 400),
          child: BounceIn(
            duration: const Duration(milliseconds: 1000),
            child: Transform.rotate(
              angle: -0.1,
              child: Translate.appName.toTextFoundation(
                type: TextType.headline1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
