import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/usecase/get_all_reels_usecase.dart';
import 'package:mobile/features/reels/domain/usecase/like_reel_usecase.dart';
import 'package:mobile/features/reels/domain/usecase/unlike_reel_usecase.dart';

import '../../../domain/usecase/comment_reel_usecase.dart';

part 'get_all_reel_event.dart';
part 'get_all_reel_state.dart';

class GetAllReelBloc extends Bloc<GetAllReelEvent, GetAllReelState> {
  final GetAllReelUseCase getAllReelUseCase;
  final LikeReelUseCase likeReelUseCase;
  final CommentReelUseCase commentReelUseCase;
  final UnLikeReelUseCase unLikeReelUseCase;
  GetAllReelBloc({
    required this.getAllReelUseCase,
    required this.likeReelUseCase,
    required this.commentReelUseCase,
    required this.unLikeReelUseCase,
  }) : super(GetAllReelInitial()) {
    on<GetAllReelsEvent>((event, emit) async {
      emit(GetAllReelLoadingState());
      var result = await getAllReelUseCase(ParamsGetAllReel());
      result.fold((l) => emit(GetAllReelErrorState(message: l.message)), (r) {
        emit(GetAllReelLoadedState(reels: r));
        print("ALL REAL ALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLl");
        print(r);
      });
    });

    on<GetAllLikeReelEvent>((event, emit) async {
      var result = await likeReelUseCase(ParamsLikeReel(reelId: event.reelId));

      result.fold((failure) => null, (sucess) {
        List<ReelEntite> reels = (state as GetAllReelLoadedState).reels;

        List<ReelEntite> updatedReels = [...reels];
        updatedReels[event.reelIndex] = ReelEntite(
          id: reels[event.reelIndex].id,
          video: reels[event.reelIndex].video,
          author: reels[event.reelIndex].author,
          comments: reels[event.reelIndex].comments!,
          isILiked: true,
          created_at: reels[event.reelIndex].created_at,
          numberOfLike: reels[event.reelIndex].numberOfLike! + 1,
          likeIDILike: sucess.id,
          content: reels[event.reelIndex].content,
        );
        emit(GetAllReelLoadedState(reels: updatedReels));
      });
    });

    on<GetAllUnLikeReelEvent>((event, emit) async {
      var result = await unLikeReelUseCase(
        ParamsUnLikeReel(
          reelId: event.reelId,
          likeId: "${event.likeId}",
        ),
      );

      result.fold((failure) {}, (sucess) {
        List<ReelEntite> reels = (state as GetAllReelLoadedState).reels;

        List<ReelEntite> updatedReels = [...reels];
        updatedReels[event.reelIndex] = ReelEntite(
          id: reels[event.reelIndex].id,
          video: reels[event.reelIndex].video,
          author: reels[event.reelIndex].author,
          comments: reels[event.reelIndex].comments!,
          isILiked: false,
          created_at: reels[event.reelIndex].created_at,
          numberOfLike: reels[event.reelIndex].numberOfLike! - 1,
          content: reels[event.reelIndex].content,
        );
        emit(GetAllReelLoadedState(reels: updatedReels));
      });
    });

    on<GetAllCommentReelEvent>((event, emit) async {
      var result = await commentReelUseCase(
          ParamsCommentReel(reelId: event.reelId, content: event.content));
      result.fold((failure) => null, (sucess) {
        List<ReelEntite> reels = (state as GetAllReelLoadedState).reels;
        List<ReelEntite> updatedReels = [];
        for (var i = 0; i < reels.length; i++) {
          ReelEntite reel = reels[i];
          if ("${reel.id}" == event.reelId) {
            reel = ReelEntite(
              id: reel.id,
              video: reel.video,
              author: reel.author,
              comments: [sucess, ...reel.comments!],
              isILiked: false,
              created_at: reel.created_at,
              numberOfLike: reel.numberOfLike! - 1,
              content: reel.content
            );
          }
          updatedReels.add(reel);
        }

        emit(GetAllReelLoadedState(reels: updatedReels));
      });
    });
  }
}
