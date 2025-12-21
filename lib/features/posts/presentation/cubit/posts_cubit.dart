import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';

part 'posts_state.dart';

@injectable
class PostsCubit extends Cubit<PostsState> {
  final GetPostsUseCase _getPostsUseCase;

  PostsCubit(this._getPostsUseCase) : super(PostsInitial());

  Future<void> loadPosts() async {
    emit(PostsLoading());
    final result = await _getPostsUseCase();
    result.fold(
      (failure) => emit(PostsError(failure.toString())),
      (posts) => emit(PostsLoaded(posts)),
    );
  }

  Future<void> refreshPosts() async {
    await loadPosts();
  }
}
