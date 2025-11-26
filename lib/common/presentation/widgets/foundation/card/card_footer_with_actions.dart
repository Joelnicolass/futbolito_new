// Compound Component: CardHeader

import 'package:flutter/material.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';

class CardFooterWithActions extends StatelessWidget {
  const CardFooterWithActions({
    super.key,
    this.prefix,
    this.primaryAction,
    this.secondaryAction,
  });

  final Widget? primaryAction;
  final Widget? secondaryAction;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (primaryAction != null) primaryAction!,
      if (secondaryAction != null) secondaryAction!,
    ];

    if (actions.isEmpty) return SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (prefix != null) prefix! else Spacer(),

        if (secondaryAction != null)
          Expanded(child: secondaryAction!)
        else
          Spacer(),
        if (primaryAction != null && secondaryAction != null)
          SizedBox(width: SpacingFoundation.sm.value),
        if (primaryAction != null) Expanded(child: primaryAction!),
      ],
    );
  }
}
