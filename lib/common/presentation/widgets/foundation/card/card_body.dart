// Compound Component: CardHeader

import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  const CardBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
