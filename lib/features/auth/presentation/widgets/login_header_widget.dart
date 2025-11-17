import 'package:flutter/widgets.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';

/// Widget del encabezado del login (logo y textos)
class LoginHeader extends StatelessWidget {
  const LoginHeader();

  @override
  Widget build(BuildContext context) {
    final t = getIt<Internationalization>().translate;

    return Column(
      children: [
        Text(
          t(Translate.appName),
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
