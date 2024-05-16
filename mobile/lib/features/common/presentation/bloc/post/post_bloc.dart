import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/post/domain/usecases/get_all_post.dart';
import 'package:mobile/features/common/post/domain/usecases/unlike_post_usecase.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';

import '../../../post/domain/usecases/like_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUseCase getAllPostUseCase;
  final LikePostUseCase likePostUseCase;
  final UnLikePostUseCase unLikePostUseCase;
  PostBloc({required this.getAllPostUseCase, required this.likePostUseCase, required this.unLikePostUseCase,})
      : super(PostInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(PostLoading());

      var posts = await getAllPostUseCase(ParamsGetAllPost());

      posts.fold((l) => emit(PostError(message: l.message)),
          (r) => emit(PostLoaded(post: r)));
    });

    on<UnLikePostEvent>((event, emit) async {
      var posts = await unLikePostUseCase(ParamsUnLikePost(postId: event.postId, likeId: event.likeId,));
      posts.fold((l) {}, (r) {
        if (state is PostLoaded) {
          List<PostEntite> post = [];
          for (int i = 0; i < (state as PostLoaded).post.length; i++) {
            if ((state as PostLoaded).post[i].id == event.postId) {
              post.add(
                PostEntite(
                  id: (state as PostLoaded).post[i].id,
                  author: (state as PostLoaded).post[i].author,
                  text: (state as PostLoaded).post[i].text,
                  created_at: (state as PostLoaded).post[i].created_at,
                  images: (state as PostLoaded).post[i].images,
                  videos: const [],
                  numberOfLike: (state as PostLoaded).post[i].numberOfLike! - 1,
                  comments: (state as PostLoaded).post[i].comments,
                  isILiked: false,
                  likeIdILike: null,
                ),
              );
            } else {
              post.add((state as PostLoaded).post[i]);
            }
          }
          emit(PostLoaded(post: post));
        }
      });
    });

    on<LikePostEvent>((event, emit) async {
      var posts = await likePostUseCase(ParamsLikePost(postId: event.postId));
      posts.fold((l) {}, (r) {
        if (state is PostLoaded) {
          List<PostEntite> post = [];
          for (int i = 0; i < (state as PostLoaded).post.length; i++) {
            if ((state as PostLoaded).post[i].id == event.postId) {
              post.add(
                PostEntite(
                  id: (state as PostLoaded).post[i].id,
                  author: (state as PostLoaded).post[i].author,
                  text: (state as PostLoaded).post[i].text,
                  created_at: (state as PostLoaded).post[i].created_at,
                  images: (state as PostLoaded).post[i].images,
                  videos: const [],
                  numberOfLike: (state as PostLoaded).post[i].numberOfLike! + 1,
                  comments: (state as PostLoaded).post[i].comments,
                  isILiked: true,
                  likeIdILike: 1,
                ),
              );
            } else {
              post.add((state as PostLoaded).post[i]);
            }
          }
          emit(PostLoaded(post: post));
        }
      });
    });
  }
}
