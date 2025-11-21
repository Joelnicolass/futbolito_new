import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/common/presentation/widgets/carousel/carousel_widget.dart';
import 'package:futbolitonew/features/home/presentation/widgets/navbar.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return ScaffoldFoundation(
      useSafeArea: false,
      padding: EdgeInsets.zero,
      onRefresh: () => Future.delayed(const Duration(seconds: 1)),
      appBar: AppBar(
        title: Translate.homePage.toTextFoundation(type: TextType.headline1),
        actions: [
          AvatarFoundation(
            showBorder: true,
            imageUrl: user?.photoUrl,
            fallbackText: user?.displayName ?? user?.email,
            radius: 20.0,
          ),
        ],
      ),
      body: ScaffoldContent(
        child: Column(
          spacing: SpacingFoundation.md.value,
          children: [
            Carousel(),

            Padding(
              padding: PaddingFoundation.md.horizontal,
              child: Column(
                spacing: SpacingFoundation.sm.value,
                children: [
                  Translate.logout.toButtonFoundation(
                    type: .text,
                    textColor: ColorFoundation.error.color,
                    suffixIcon: Icon(Icons.logout),
                    onPressed: () async {
                      await ref.read(authProvider.notifier).signOut();
                      if (context.mounted) context.go('/login');
                    },
                  ),
                ],
              ),
            ),

            LiquidGlassBottomBar(
              tabs: [
                LiquidGlassBottomBarTab(label: 'test 1', icon: Icons.home),
                LiquidGlassBottomBarTab(label: 'test 2', icon: Icons.search),
              ],
              onTabSelected: (index) {
                print('Selected tab: $index');
              },
              selectedIndex: 0,
            ),
          ],
        ),
      ),
    );
  }
}
