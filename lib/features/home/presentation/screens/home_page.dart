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
import 'package:futbolitonew/features/home/presentation/widgets/glass_navbar.dart';
import 'package:futbolitonew/features/home/presentation/widgets/adaptive_navbar.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return ScaffoldFoundation(
      bottomNavigationBar: Container(
        child: AdaptiveBottomBar(
          tabs: [
            AdaptiveTab(label: 'Inicio', icon: Icons.home_outlined),
            AdaptiveTab(label: 'Partidos', icon: Icons.sports_soccer),
            AdaptiveTab(label: 'Equipos', icon: Icons.shield_outlined),
            AdaptiveTab(label: 'Perfil', icon: Icons.person_2_outlined),
          ],
          onTabSelected: (index) {
            print('Selected tab: $index');
          },
          selectedIndex: 0,
        ),
      ),
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

            SpacingFoundation.lg.spacer,
            AdaptiveBottomBar(
              tabs: [
                AdaptiveTab(label: 'Inicio', icon: Icons.home_outlined),
                AdaptiveTab(label: 'Partidos', icon: Icons.sports_soccer),
                AdaptiveTab(label: 'Equipos', icon: Icons.shield_outlined),
                AdaptiveTab(label: 'Perfil', icon: Icons.person_2_outlined),
              ],
              onTabSelected: (index) {
                print('Selected tab: $index');
              },
              selectedIndex: 0,
            ),

            AdaptiveBottomBar(
              forceStyle: .material,
              tabs: [
                AdaptiveTab(label: 'Inicio', icon: Icons.home_outlined),
                AdaptiveTab(label: 'Partidos', icon: Icons.sports_soccer),
                AdaptiveTab(label: 'Equipos', icon: Icons.shield_outlined),
                AdaptiveTab(label: 'Perfil', icon: Icons.person_2_outlined),
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
