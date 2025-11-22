import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return Center(
      child: Padding(
        padding: PaddingFoundation.lg.all,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: SpacingFoundation.lg.value,
          children: [
            AvatarFoundation(
              showBorder: true,
              imageUrl: user?.photoUrl,
              fallbackText: user?.displayName ?? user?.email,
              radius: 60.0,
            ),
            Column(
              spacing: SpacingFoundation.xs.value,
              children: [
                (user?.displayName ??
                        Translate.userDefault.toTextFoundationString())
                    .toTextFoundation(type: TextType.headline2),
                if (user?.email != null)
                  (user?.email ?? '').toTextFoundation(
                    type: TextType.bodyText1,
                  ),
              ],
            ),
            SpacingFoundation.xl.spacer,
            Translate.logout.toButtonFoundation(
              type: .text,
              textColor: ColorFoundation.error.color,
              suffixIcon: const Icon(Icons.logout),
              onPressed: () async {
                await ref.read(authProvider.notifier).signOut();
                if (context.mounted) context.go('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
