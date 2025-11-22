import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/common/domain/entities/padding_foundation_entity.dart';
import 'package:futbolitonew/common/domain/entities/spacing_foundation_entity.dart';
import 'package:futbolitonew/common/presentation/widgets/carousel/carousel_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/scaffold/scaffold_content_foundation_widget.dart';
import 'package:futbolitonew/common/presentation/widgets/foundation/text/text_foundation_widget.dart';
import 'package:futbolitonew/core/intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          overlayColor: WidgetStateProperty.fromMap({
            WidgetState.pressed: Colors.transparent,
          }),
          labelStyle: TextStyle(
            fontSize: 12,
            fontFamily: GoogleFonts.quicksand().fontFamily,
          ),

          tabs: [
            Tab(icon: Icon(Icons.sports_soccer, size: 20), text: 'Feed'),
            Tab(
              icon: Icon(Icons.notifications_active_outlined, size: 20),
              text: 'Novedades',
            ),
          ],
        ),
        body: const TabBarView(
          controller: null,
          children: [
            Page1(),
            Center(child: Text('Page 2')),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldContent(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: Column(
        crossAxisAlignment: .start,
        spacing: SpacingFoundation.md.value,
        children: [HeaderSection(), const Carousel()],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingFoundation.md.horizontal,
      child: Column(
        spacing: SpacingFoundation.sm.value,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SpacingFoundation.lg.spacer,
          Translate.homeWelcome.toTextFoundation(type: TextType.bodyText1),

          Translate.homeDescription.toTextFoundation(type: TextType.bodyText2),
        ],
      ),
    );
  }
}
