import 'package:futbolitonew/features/home/presentation/screens/home_page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
);
