import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:futbolitonew/core/intl/intl.dart';

part 'navigation_provider.g.dart';

/// Provider para gestionar el índice de la tab actual en la navegación
@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() => 0;

  /// Cambia la tab actual
  void changeTab(int index) {
    state = index;
  }

  /// Obtiene el título de la página actual según el índice
  Translate getCurrentTitle() {
    switch (state) {
      case 0:
        return Translate.homePage;
      case 1:
        return Translate.matchesTitle;
      case 2:
        return Translate.teamsTitle;
      case 3:
        return Translate.profileTitle;
      default:
        return Translate.homePage;
    }
  }
}
