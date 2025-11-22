import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/providers/navigation_provider.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/features/home/presentation/screens/home_page.dart';
import 'package:futbolitonew/features/home/presentation/widgets/adaptive_navbar.dart';
import 'package:futbolitonew/features/home/presentation/widgets/glass_navbar.dart';
import 'package:futbolitonew/features/matches/presentation/screens/matches_page.dart';
import 'package:futbolitonew/features/profile/presentation/screens/profile_page.dart';
import 'package:futbolitonew/features/teams/presentation/screens/teams_page.dart';

/// Widget principal que gestiona la navegación entre las diferentes secciones de la app
/// Implementa un único Scaffold siguiendo las recomendaciones de Flutter:
/// "It's typically not necessary to nest scaffolds"
class MainNavigationWidget extends ConsumerWidget {
  const MainNavigationWidget({super.key});

  /// Lista de páginas que se muestran en cada tab
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

    /// Configuración de las tabs del bottom navigation bar
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

    // Obtener el título actual de la página
    final currentTitle = ref
        .read(navigationIndexProvider.notifier)
        .getCurrentTitle();

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: currentTitle.toTextFoundation(type: TextType.headline1),
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
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: AdaptiveBottomBar(
        tabs: tabs,
        selectedIndex: currentIndex,
        onTabSelected: (index) {
          ref.read(navigationIndexProvider.notifier).changeTab(index);
        },
      ),
    );
  }
}
