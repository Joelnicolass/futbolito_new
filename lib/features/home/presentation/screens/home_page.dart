import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futbolitonew/features/home/presentation/screens/feed_page.dart';
import 'package:futbolitonew/features/home/presentation/screens/notifications_page.dart';
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
              icon: Icon(Icons.notifications_none_rounded, size: 20),
              text: 'Novedades',
            ),
          ],
        ),
        body: const TabBarView(
          controller: null,
          children: [FeedPage(), NotificationsPage()],
        ),
      ),
    );
  }
}
