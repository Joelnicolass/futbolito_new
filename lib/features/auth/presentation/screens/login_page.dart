import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/presentation/screens/loading_fullscreen/loading_fullscreen.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/');
          });
        }

        return const LoginScreen();
      },
      loading: () => const LoadingFullScreen(),
      error: (_, __) => const LoginScreen(),
    );
  }
}
