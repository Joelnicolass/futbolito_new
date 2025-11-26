import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/providers/navigation_provider.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/home/presentation/screens/home_page.dart';
import 'package:futbolitonew/common/presentation/widgets/bottom_navbar/adaptive_navbar.dart';
import 'package:futbolitonew/common/presentation/widgets/bottom_navbar/glass_navbar.dart';
import 'package:futbolitonew/features/matches/presentation/screens/matches_page.dart';
import 'package:futbolitonew/features/profile/presentation/screens/profile_page.dart';
import 'package:futbolitonew/features/teams/presentation/screens/teams_page.dart';

class MainNavigationWidget extends ConsumerWidget {
  const MainNavigationWidget({super.key});

  static final List<Widget> _pages = [
    const HomePage(),
    const MatchesPage(),
    const TeamsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);
    final t = getIt<Internationalization>().translate;
    final user = ref.watch(authProvider).value;

    final tabs = [
      AdaptiveTab(
        label: t(Translate.homeTab),
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
      ),
      AdaptiveTab(
        label: t(Translate.matchesTab),
        icon: Icons.sports_soccer_outlined,
        selectedIcon: Icons.sports_soccer,
      ),
      AdaptiveTab(
        label: t(Translate.teamsTab),
        icon: Icons.shield_outlined,
        selectedIcon: Icons.shield,
      ),
      AdaptiveTab(
        label: t(Translate.profileTab),
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
      ),
    ];

    final currentTitle = ref
        .read(navigationIndexProvider.notifier)
        .getCurrentTitle();

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              onPressed: () {
                // Acción del botón central
              },
              elevation: 2,
              highlightElevation: 0,
              child: Icon(
                Icons.add,
                color: ColorFoundation.background.color,
                size: 25,
              ),
              backgroundColor: ColorFoundation.secondary.color,
              foregroundColor: ColorFoundation.white.color,
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: currentTitle.toTextFoundation(type: TextType.headline2),
        shadowColor: ColorFoundation.background.color,
        surfaceTintColor: ColorFoundation.background.color,
        actions: [
          AvatarFoundation(
            showBorder: true,
            imageUrl: user?.photoUrl,
            fallbackText: user?.displayName ?? user?.email,
            radius: 20.0,
          ),
        ],
      ),
      body: IndexedStack(
        key: ValueKey(currentIndex),
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AdaptiveBottomBar(
        tabs: tabs,
        selectedIndex: currentIndex,
        onTabSelected: (index) {
          ref.read(navigationIndexProvider.notifier).changeTab(index);
        },
        hasNotch: true,
      ),
    );
  }
}
