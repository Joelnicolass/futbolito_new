import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';

class ScaffoldFoundation extends StatelessWidget {
  const ScaffoldFoundation({super.key, required this.body, this.appBar});

  final Widget body;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(PaddingFoundation.medium.value),
          child: FadeIn(child: body),
        ),
      ),
    );
  }
}
