import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../features/counter/presentation/pages/counter_page.dart';
import '../../features/posts/presentation/pages/posts_page.dart';
import '../../features/posts/presentation/pages/post_detail_page.dart';

@lazySingleton
class AppRouter {
  static const String counter = '/counter';
  static const String posts = '/posts';
  static const String postDetail = '/posts/:id';

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
        routes: [
          GoRoute(
            path: ':id',
            name: 'postDetail',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return PostDetailPage(postId: id);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const CounterPage(),
  );
}
