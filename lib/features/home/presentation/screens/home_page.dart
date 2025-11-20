import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/providers/test_provider/test_provider.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = getIt<Internationalization>().translate;
    final user = ref.watch(authProvider).value;

    return ScaffoldFoundation(
      onRefresh: () => ref.read(testProviderProvider.notifier).loadItems(),
      appBar: AppBar(
        title: Text(
          t(Translate.homePage),
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: SpacingFoundation.md.value,
        actionsPadding: PaddingFoundation.md.horizontal,
        actions: [
          AvatarFoundation(
            showBorder: true,
            imageUrl: user?.photoUrl,
            fallbackText: user?.displayName ?? user?.email,
            radius: 20.0,
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
