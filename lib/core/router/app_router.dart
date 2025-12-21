import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../features/counter/presentation/pages/counter_page.dart';
import '../../features/posts/presentation/pages/posts_page.dart';

@lazySingleton
class AppRouter {
  static const String counter = '/counter';
  static const String posts = '/posts';

  GoRouter get router => _router;

  final GoRouter _router = GoRouter(
    initialLocation: counter,
    routes: [
      GoRoute(
        path: counter,
        name: 'counter',
        builder: (context, state) => const CounterPage(),
      ),
      GoRoute(
        path: posts,
        name: 'posts',
        builder: (context, state) => const PostsPage(),
      ),
    ],
    errorBuilder: (context, state) => const CounterPage(),
  );
}
