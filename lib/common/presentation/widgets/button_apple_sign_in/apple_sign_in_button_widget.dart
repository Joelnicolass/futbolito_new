import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';

class AppleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const AppleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (TargetPlatform.iOS == Theme.of(context).platform)
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.apple, size: 24),
          label: TextFoundation(
            text: isLoading ? 'Iniciando sesión...' : 'Continuar con Apple',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      );
    return const SizedBox();
  }
}
