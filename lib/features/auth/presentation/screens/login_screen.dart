import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/button_apple_sign_in/apple_sign_in_button_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/button_google_sign_in/google_sign_in_button_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/auth/presentation/widgets/login_header_widget.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ScaffoldContent(
        padding: PaddingFoundation.md.all,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginHeader(),
            SpacingFoundation.xl.spacer,
            Column(
              spacing: SpacingFoundation.md.value,
              children: [
                GoogleSignInButton(
                  onPressed: () =>
                      ref.read(authProvider.notifier).signInWithGoogle(),
                ),
                AppleSignInButton(
                  onPressed: () =>
                      ref.read(authProvider.notifier).signInWithApple(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
