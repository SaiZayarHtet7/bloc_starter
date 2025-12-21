import 'package:bloc_starter/features/posts/domain/entities/post_entity.dart';
import 'package:bloc_starter/features/posts/domain/repositories/post_repository.dart';
import 'package:bloc_starter/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:bloc_starter/features/posts/presentation/cubit/posts_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

class MockGetPostsUseCase extends Mock implements GetPostsUseCase {}

void main() {
  late MockGetPostsUseCase mockGetPostsUseCase;

  setUp(() {
    mockGetPostsUseCase = MockGetPostsUseCase();
  });

  group('PostsCubit', () {
    const tPost1 = PostEntity(
      id: 1,
      userId: 1,
      title: 'Test Post 1',
      body: 'This is test post 1 body',
    );

    const tPost2 = PostEntity(
      id: 2,
      userId: 1,
      title: 'Test Post 2',
      body: 'This is test post 2 body',
    );

    const tPosts = [tPost1, tPost2];

    blocTest<PostsCubit, PostsState>(
      'emits [PostsLoading, PostsLoaded] when loadPosts is successful',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => const Right(tPosts));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) => cubit.loadPosts(),
      expect: () => [
        PostsLoading(),
        const PostsLoaded(tPosts),
      ],
      verify: (_) {
        verify(() => mockGetPostsUseCase()).called(1);
      },
    );

    blocTest<PostsCubit, PostsState>(
      'emits [PostsLoading, PostsError] when loadPosts fails',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to fetch posts')));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) => cubit.loadPosts(),
      expect: () => [
        PostsLoading(),
        isA<PostsError>(),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits [PostsLoading, PostsLoaded] when refreshPosts is successful',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => const Right(tPosts));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) => cubit.refreshPosts(),
      expect: () => [
        PostsLoading(),
        const PostsLoaded(tPosts),
      ],
      verify: (_) {
        verify(() => mockGetPostsUseCase()).called(1);
      },
    );

    blocTest<PostsCubit, PostsState>(
      'emits [PostsLoading, PostsError] when refreshPosts fails',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => Left(Exception('Failed to refresh posts')));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) => cubit.refreshPosts(),
      expect: () => [
        PostsLoading(),
        isA<PostsError>(),
      ],
    );

    blocTest<PostsCubit, PostsState>(
      'emits empty list when no posts are available',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => const Right([]));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) => cubit.loadPosts(),
      expect: () => [
        PostsLoading(),
        const PostsLoaded([]),
      ],
    );

    test('initial state is PostsInitial', () {
      final cubit = PostsCubit(mockGetPostsUseCase);
      expect(cubit.state, PostsInitial());
    });

    blocTest<PostsCubit, PostsState>(
      'handles multiple refresh calls',
      build: () {
        when(() => mockGetPostsUseCase())
            .thenAnswer((_) async => const Right(tPosts));
        return PostsCubit(mockGetPostsUseCase);
      },
      act: (cubit) async {
        await cubit.refreshPosts();
        await cubit.refreshPosts();
      },
      expect: () => [
        PostsLoading(),
        const PostsLoaded(tPosts),
        PostsLoading(),
        const PostsLoaded(tPosts),
      ],
      verify: (_) {
        verify(() => mockGetPostsUseCase()).called(2);
      },
    );
  });
}
