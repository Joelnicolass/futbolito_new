import 'package:flutter/material.dart';
import 'package:futbolitonew/common/presentation/widgets/bottom_navbar/glass_navbar.dart';

/// Material Design implementation of the bottom navigation bar
/// This provides a native Material Design experience for Android devices
class MaterialBottomBar extends StatelessWidget {
  const MaterialBottomBar({
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
    this.hasNotch = false,
  });

  final List<AdaptiveTab> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final AdaptiveExtraButton? extraButton;
  final double spacing;
  final double horizontalPadding;
  final double bottomPadding;
  final double barHeight;
  final dynamic glassSettings; // Ignored in Material implementation
  final bool showIndicator;
  final Color? indicatorColor;
  final bool fake; // Ignored in Material implementation
  final bool hasNotch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        right: horizontalPadding,
        left: horizontalPadding,
        bottom: bottomPadding,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: theme.bottomNavigationBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  for (var i = 0; i < tabs.length; i++) ...[
                    Expanded(
                      child: _MaterialTab(
                        tab: tabs[i],
                        selected: selectedIndex == i,
                        onTap: () => onTabSelected(i),
                        indicatorColor: indicatorColor ?? Colors.transparent,
                      ),
                    ),
                    // Espacio del notch en el medio
                    if (hasNotch && i == (tabs.length / 2 - 1).floor())
                      const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            ),
          ),
          if (extraButton != null) ...[
            SizedBox(width: spacing),
            _MaterialExtraButton(config: extraButton!),
          ],
        ],
      ),
    );
  }
}

class _MaterialTab extends StatelessWidget {
  const _MaterialTab({
    required this.tab,
    required this.selected,
    required this.onTap,
    required this.indicatorColor,
  });

  final AdaptiveTab tab;
  final bool selected;
  final VoidCallback onTap;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = selected
        ? theme.bottomNavigationBarTheme.selectedItemColor
        : theme.bottomNavigationBarTheme.unselectedItemColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: selected ? 18 : 12,
                  vertical: selected ? 4 : 2,
                ),
                decoration: BoxDecoration(
                  color: selected ? indicatorColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  selected ? (tab.selectedIcon ?? tab.icon) : tab.icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  tab.label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MaterialExtraButton extends StatelessWidget {
  const _MaterialExtraButton({required this.config});

  final AdaptiveExtraButton config;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton(
      onPressed: config.onTap,
      tooltip: config.label,
      elevation: 3,
      child: Icon(
        config.icon,
        size: 24,
        color: theme.colorScheme.onPrimaryContainer,
      ),
    );
  }
}
