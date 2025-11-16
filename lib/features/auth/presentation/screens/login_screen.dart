import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/auth/presentation/widgets/google_sign_in_button.dart';
import 'package:go_router/go_router.dart';

/// Pantalla de login
/// Permite al usuario iniciar sesión con Google
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (user) {
        // Si hay usuario, navegar a home
        if (user != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) context.go('/');
          });
        }
        return const _LoginContent();
      },
      loading: () => const _LoadingContent(),
      error: (error, stack) => _ErrorContent(error: error.toString()),
    );
  }
}

/// Widget del contenido principal de login
class _LoginContent extends ConsumerWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LoginHeader(),
                const SizedBox(height: 64),
                GoogleSignInButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signInWithGoogle();
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget del estado de carga
class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LoginHeader(),
                const SizedBox(height: 64),
                GoogleSignInButton(onPressed: () {}, isLoading: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget del estado de error
class _ErrorContent extends ConsumerWidget {
  final String error;

  const _ErrorContent({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _LoginHeader(),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GoogleSignInButton(
                  onPressed: () {
                    ref.read(authProvider.notifier).signInWithGoogle();
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget del encabezado del login (logo y textos)
class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.sports_soccer,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 24),
        const Text(
          'Futbolito',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Organiza tus partidos de fútbol',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
