import 'package:futbolitonew/features/auth/presentation/screens/login_page.dart';
import 'package:futbolitonew/features/home/presentation/screens/home_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
  ],
  initialLocation: '/login',
);
