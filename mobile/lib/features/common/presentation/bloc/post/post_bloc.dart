import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/post/domain/usecases/get_all_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUseCase getAllPostUseCase;
  PostBloc({required this.getAllPostUseCase}) : super(PostInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(PostLoading());
      var posts = await getAllPostUseCase(ParamsGetAllPost());
      
      posts.fold(
          (l) => emit(PostError(message: l.message)), (r) => emit(PostLoaded(post: r)));
      
    });
  }
}
