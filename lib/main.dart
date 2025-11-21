import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/core/di/register_dependencies.dart';
import 'package:futbolitonew/core/navigator/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Futbolito',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: ColorFoundation.background.color,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorFoundation.background.color,
          elevation: 0,
          actionsPadding: PaddingFoundation.md.horizontal,
          titleSpacing: SpacingFoundation.md.value,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorFoundation.surface.color,
          selectedItemColor: ColorFoundation.secondary.color,
          unselectedItemColor: ColorFoundation.dark.color,
        ),
        colorScheme: ColorScheme.light(
          primary: ColorFoundation.primary800.color,
          primaryContainer: ColorFoundation.background.color,
          onPrimary: ColorFoundation.dark.color,
          secondary: ColorFoundation.secondary.color,
          surface: ColorFoundation.surface.color,
          tertiary: ColorFoundation.tertiary.color,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
