import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/post/domain/usecases/comment_post_usecase.dart';
import 'package:mobile/features/common/post/domain/usecases/get_all_post.dart';
import 'package:mobile/features/common/post/domain/usecases/unlike_post_usecase.dart';

import '../../../post/domain/usecases/like_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPostUseCase getAllPostUseCase;
  final LikePostUseCase likePostUseCase;
  final UnLikePostUseCase unLikePostUseCase;
  final CommentPostUseCase commentPostUseCase;
  PostBloc({
    required this.getAllPostUseCase,
    required this.likePostUseCase,
    required this.unLikePostUseCase,
    required this.commentPostUseCase,
  }) : super(PostInitial()) {
    on<GetAllPostsEvent>((event, emit) async {
      emit(PostLoading());

      var posts = await getAllPostUseCase(ParamsGetAllPost());

      posts.fold((l) => emit(PostError(message: l.message)),
          (r) => emit(PostLoaded(post: r)));
    });

    on<UnLikePostEvent>((event, emit) async {
      var posts = await unLikePostUseCase(ParamsUnLikePost(
        postId: event.postId,
        likeId: event.likeId,
      ));
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
                  likeIdILike: r.id,
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

    on<CommentPostEvent>((event, emit) async {
      var result = await commentPostUseCase(
          ParamsCommentPost(postId: event.postId, content: event.content));
      result.fold((failure) => null, (sucess) {
        List<PostEntite> posts = (state as PostLoaded).post;
        List<PostEntite> updatedPosts = [];
        for (var i = 0; i < posts.length; i++) {
          PostEntite post = posts[i];
          if (post.id == event.postId) {
            post = PostEntite(
              id: post.id,
              author: post.author,
              text: post.text,
              created_at: post.created_at,
              images: post.images,
              videos: const [],
              numberOfLike: post.numberOfLike,
              comments: [sucess, ...post.comments!],
              isILiked: post.isILiked,
              likeIdILike: post.likeIdILike,
            );
          }
          updatedPosts.add(post);
        }

        emit(PostLoaded(post: updatedPosts));
      });
    });
  }
}
