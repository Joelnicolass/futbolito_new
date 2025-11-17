import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/scaffold_foundation/scaffold_foundation_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = getIt<Internationalization>().translate;

    return ScaffoldFoundation(
      appBar: AppBar(
        title: Text(t(Translate.homePage)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: PaddingFoundation.medium.right,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                ref.read(authProvider).value?.photoUrl ?? '',
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).signOut();
            if (context.mounted) context.go('/login');
          },
          child: Text(t(Translate.logout)),
        ),
      ),
    );
  }
}
