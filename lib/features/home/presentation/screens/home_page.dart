import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).signOut();
            if (context.mounted) {
              context.go('/login');
            }
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
