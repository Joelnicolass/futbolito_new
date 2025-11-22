import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/bottom_navbar/glass_navbar.dart';
import 'package:futbolitonew/common/presentation/widgets/bottom_navbar/material_navbar.dart';

enum BottomBarStyle { glass, material }

/// Adaptive bottom navigation bar that automatically selects the appropriate
/// implementation based on the platform:
/// - iOS/macOS: Uses LiquidGlassBottomBar with glass morphism effect
/// - Android/Others: Uses MaterialBottomBar with native Material Design
class AdaptiveBottomBar extends StatelessWidget {
  const AdaptiveBottomBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.extraButton,
    this.spacing = 8,
    this.horizontalPadding = 20,
    this.bottomPadding = 20,
    this.barHeight = 64,
    this.glassSettings,
    this.showIndicator = true,
    this.indicatorColor,
    this.fake = false,
    this.forceStyle,
  });

  final List<AdaptiveTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final AdaptiveExtraButton? extraButton;
  final double spacing;
  final double horizontalPadding;
  final double bottomPadding;
  final double barHeight;
  final dynamic glassSettings;
  final bool showIndicator;
  final Color? indicatorColor;
  final bool fake;

  /// Force a specific style regardless of platform
  /// Options: 'glass', 'material', or null for automatic
  final BottomBarStyle? forceStyle;

  bool get _shouldUseLiquidGlass {
    if (forceStyle == BottomBarStyle.glass) return true;
    if (forceStyle == BottomBarStyle.material) return false;

    // Use Liquid Glass for iOS, Material for everything else
    if (kIsWeb) return false;
    return Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldUseLiquidGlass) {
      return LiquidGlassBottomBar(
        tabs: tabs,
        selectedIndex: selectedIndex,
        onTabSelected: onTabSelected,
        extraButton: extraButton,
        spacing: spacing,
        horizontalPadding: horizontalPadding,
        bottomPadding: bottomPadding,
        barHeight: barHeight,
        glassSettings: glassSettings,
        showIndicator: showIndicator,
        indicatorColor: indicatorColor,
        fake: fake,
      );
    }

    return MaterialBottomBar(
      tabs: tabs,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
      extraButton: extraButton,
      spacing: spacing,
      horizontalPadding: horizontalPadding,
      bottomPadding: bottomPadding,
      barHeight: barHeight,
      glassSettings: glassSettings,
      showIndicator: showIndicator,
      indicatorColor: indicatorColor,
      fake: fake,
    );
  }
}
