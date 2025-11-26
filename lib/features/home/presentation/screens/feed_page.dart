import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_footer_with_actions.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_header.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/card/card_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/home/data/datasources/remote/remote_datasource.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authProvider).value;
    final invitations = getIt<InvitationsRemoteDataSource>()
        .fetchPendingFriendRequests(userId: user!.id, email: user.email)
        .then((value) {
          return value;
        });

    return ScaffoldContent(
      padding: PaddingFoundation.md.all,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: Column(
        crossAxisAlignment: .start,
        spacing: SpacingFoundation.md.value,
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: invitations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No hay solicitudes de amistad pendientes.'),
                );
              } else {
                final requests = snapshot.data!;
                return Column(
                  children: requests.map((request) {
                    final sender = request['sender'];
                    return CardFriendRequest(
                      name: sender['display_name'] ?? 'Nombre Desconocido',
                      email: sender['email'] ?? 'Email Desconocido',
                      imageUrl: sender['photo_url'],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CardFriendRequest extends StatelessWidget {
  const CardFriendRequest({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

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
