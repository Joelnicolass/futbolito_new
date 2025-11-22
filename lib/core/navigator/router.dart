import 'package:futbolitonew/features/auth/presentation/screens/login_page.dart';
import 'package:futbolitonew/common/presentation/widgets/navigation/main_navigation_widget.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigationWidget(),
    ),
  ],
  initialLocation: '/login',
);
