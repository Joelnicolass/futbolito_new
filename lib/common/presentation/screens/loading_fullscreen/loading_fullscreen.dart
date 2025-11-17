import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = getIt<Internationalization>().translate;

    return Scaffold(
      body: FadeIn(
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: PaddingFoundation.medium.value),
              Text(t(Translate.loading)),
            ],
          ),
        ),
      ),
    );
  }
}
