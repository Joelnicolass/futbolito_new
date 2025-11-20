import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = getIt<Internationalization>().translate;
    final user = ref.watch(authProvider).value;

    return ScaffoldFoundation(
      appBar: AppBar(
        title: Text(t(Translate.homePage)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: PaddingFoundation.medium.right,
            child: AvatarFoundation(
              imageUrl: user?.photoUrl,
              fallbackText: user?.displayName ?? user?.email,
              radius: 18,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).signOut();

                if (context.mounted) context.go('/login');
              },
              child: Text(t(Translate.logout)),
            ),
          ],
        ),
      ),
    );
  }
}
