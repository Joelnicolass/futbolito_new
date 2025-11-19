import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/colors_foundation_entity.dart';
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
        colorScheme: ColorScheme.light(
          primary: ColorsFoundation.primary.color,
          primaryContainer: ColorsFoundation.background.color,
          secondary: ColorsFoundation.secondary.color,
          surface: ColorsFoundation.surface.color,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
