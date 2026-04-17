import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_post_by_id_usecase.dart';

part 'post_detail_state.dart';

@injectable
class PostDetailCubit extends Cubit<PostDetailState> {
  final GetPostByIdUseCase _getPostByIdUseCase;

  PostDetailCubit(this._getPostByIdUseCase) : super(PostDetailInitial());

  Future<void> loadPost(int id) async {
    emit(PostDetailLoading());
    final result = await _getPostByIdUseCase(id);
    result.fold(
      (failure) => emit(PostDetailError(failure.toString())),
      (post) => emit(PostDetailLoaded(post)),
    );
  }
}
