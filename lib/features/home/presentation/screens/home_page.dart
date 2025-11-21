import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/color_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/avatar/avatar_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/button/button_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_widget.dart';
import 'package:futbolitonew/features/auth/presentation/providers/auth_provider.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;

    return ScaffoldFoundation(
      useSafeArea: false,
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
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width * 0.8,
                itemBuilder: (context, index) {
                  return FadeIn(
                    delay: Duration(milliseconds: 100 * index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorFoundation.cardBackground.color,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      margin: EdgeInsets.only(
                        right: index == 9 ? 0 : SpacingFoundation.md.value,
                        bottom: 16,
                        top: 16,
                      ),
                      width: 200,
                      child: ListTile(
                        title: Text(
                          'Card ${index + 1}',
                        ).toTextFoundation(style: TextStyle(fontSize: 24)),
                        subtitle: Text(
                          'Descripción del equipo ${index + 1}',
                        ).toTextFoundation(),
                        leading: Icon(Icons.sports_soccer, size: 48),
                        iconColor: ColorFoundation.primary.color,
                      ),
                    ),
                  );
                },
              ),
            ),
            SpacingFoundation.md.spacer,
            TextButton(
              onPressed: () async {
                await ref.read(authProvider.notifier).signOut();

                if (context.mounted) context.go('/login');
              },
              child: Translate.logout.toTextFoundation(
                type: TextType.bodyText1,
              ),
            ),

            Translate.appName.toButtonFoundation(
              type: ButtonFoundationType.primary,
              onPressed: () => print('My Button Pressed'),
            ),

            'my button'.toButtonFoundation(
              type: ButtonFoundationType.primary,
              onPressed: () => print('My Button Pressed'),
              prefixIcon: Icon(Icons.star),
            ),

            'alternativo'.toButtonFoundation(
              type: ButtonFoundationType.alternative,
              onPressed: () => print('Botón Alternativo Presionado'),
            ),

            ButtonFoundation(
              text: 'Button 1',
              type: ButtonFoundationType.primary,
              onPressed: () => print('Primary Button Pressed'),
            ),

            ButtonFoundation(
              text: 'Button 2',
              type: ButtonFoundationType.secondary,
              onPressed: () => print('Secondary Button Pressed'),
            ),
            ButtonFoundation(
              text: 'Button 2',
              type: ButtonFoundationType.outlined,
              onPressed: () => print('Outlined Button Pressed'),
            ),
            ButtonFoundation(
              text: 'Button 3',
              type: ButtonFoundationType.text,
              onPressed: () => print('Text Button Pressed'),
            ),
            ButtonFoundation(
              text: 'Button 4',
              type: ButtonFoundationType.link,
              onPressed: () => print('Link Button Pressed'),
            ),
          ],
        ),
      ),
    );
  }
}
