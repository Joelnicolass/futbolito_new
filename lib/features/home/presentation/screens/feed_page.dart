import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/skeleton/skeleton_foundation_widget.dart';
import 'package:futbolitonew/features/home/presentation/providers/invitation_friend/invitations_provider.dart';
import 'package:futbolitonew/features/home/presentation/widgets/card_friend_request_widget.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldContent(
      padding: PaddingFoundation.md.all,
      onRefresh: () =>
          ref.read(invitationsProvider.notifier).refreshInvitationsFriend(),
      useConstrainedBox: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [InvitationsFriendsSection()],
      ),
    );
  }
}

class InvitationsFriendsSection extends ConsumerWidget {
  const InvitationsFriendsSection({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final invitations = ref.watch(invitationsProvider);

    return invitations.when(
      data: (data) => FadeIn(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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

            SpacingFoundation.xxl.spacer,
          ],
        ),
      ),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SpacingFoundation.md.value,
        children: [
          ...List.generate(
            5,
            (index) => FadeIn(
              delay: Duration(milliseconds: 100 * index),
              child: SkeletonFoundation(height: 150, radius: 12),
            ),
          ),
        ],
      ),
    );
  }
}
