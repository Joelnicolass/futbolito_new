import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_footer_with_actions.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_header.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_widget.dart';

class CardFriendRequest extends StatelessWidget {
  const CardFriendRequest({
    super.key,
    required this.invitationId,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  final String invitationId;
  final String name;
  final String email;

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CardFoundation(
      width: double.infinity,

      header: CardHeader(
        title: name,
        subtitle: email,
        icon: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(60),
            borderRadius: BorderRadius.circular(20),
          ),
          child: AvatarFoundation(
            backgroundColor: Colors.transparent,
            imageUrl: imageUrl,
            radius: 20,
          ),
        ),
      ),

      footer: CardFooterWithActions(
        primaryAction: ButtonFoundation(
          text: 'Aceptar',
          onPressed: () {},
          type: .primary,
          size: .sm,
        ),
        secondaryAction: ButtonFoundation(
          text: 'Rechazar',
          onPressed: () {},
          type: .secondary,
          size: .sm,
        ),
      ),
    );
  }
}
