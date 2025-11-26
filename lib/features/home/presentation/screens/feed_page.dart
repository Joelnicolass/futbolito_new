import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/screens/loading_fullscreen/loading_fullscreen.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_footer_with_actions.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_header.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/home/presentation/providers/invitation_friend/invitations_provider.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authProvider).value;
    final invitations = ref.watch(invitationsProvider);

    return invitations.when(
      data: (data) => ScaffoldContent(
        padding: PaddingFoundation.md.all,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: Column(
          crossAxisAlignment: .start,
          spacing: SpacingFoundation.md.value,
          children: [
            if (data.pendingRequests.isEmpty)
              const Center(
                child: Text('No hay solicitudes de amistad pendientes.'),
              )
            else
              ...data.pendingRequests.map(
                (invitation) => CardFriendRequest(
                  invitationId: invitation.id,
                  name: invitation.displayName,
                  email: invitation.email,
                  imageUrl: invitation.photoUrl,
                ),
              ),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingFullScreen(),
    );
  }
}

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
          type: .secondary,
          size: .sm,
        ),
        secondaryAction: ButtonFoundation(
          text: 'Rechazar',
          onPressed: () {},
          type: .primary,
          size: .sm,
        ),
      ),
    );
  }
}
