import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reels/data/model/reel_model.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/usecase/get_all_reels_usecase.dart';
import 'package:mobile/features/reels/domain/usecase/like_reel_usecase.dart';

part 'get_all_reel_event.dart';
part 'get_all_reel_state.dart';

class GetAllReelBloc extends Bloc<GetAllReelEvent, GetAllReelState> {
  final GetAllReelUseCase getAllReelUseCase;
  final LikeReelUseCase likeReelUseCase;
  GetAllReelBloc(
      {required this.getAllReelUseCase, required this.likeReelUseCase})
      : super(GetAllReelInitial()) {
    on<GetAllReelsEvent>((event, emit) async {
      emit(GetAllReelLoadingState());
      var result = await getAllReelUseCase(ParamsGetAllReel());
      result.fold((l) => emit(GetAllReelErrorState(message: l.message)),
          (r) => emit(GetAllReelLoadedState(reels: r)));
    });

    on<GetAllLikeReelEvent>((event, emit) async {
      if (state is GetAllReelLoadedState) {
        List<ReelEntite> reels = (state as GetAllReelLoadedState).reels;
        List<ReelEntite> updatedReels = [];
        for (var i = 0; i < reels.length; i++) {
          ReelEntite reel = reels[i];
          if ("${reel.id}" == event.reelId) {
            reel = ReelEntite(
              id: reel.id,
              video: reel.video,
              author: reel.author,
              comments: reel.comments,
              isILiked: true,
              created_at: reel.created_at,
              numberOfLike: reel.numberOfLike! + 1,
            );
          }
          updatedReels.add(reel);
        }

        emit(GetAllReelLoadedState(reels: updatedReels));
      }
      var result = await likeReelUseCase(ParamsLikeReel(reelId: event.reelId));
      result.fold(
        (failure) {
          if (state is GetAllReelLoadedState) {
        List<ReelEntite> reels = (state as GetAllReelLoadedState).reels;
        List<ReelEntite> updatedReels = [];
        for (var i = 0; i < reels.length; i++) {
          ReelEntite reel = reels[i];
          if ("${reel.id}" == event.reelId) {
            reel = ReelEntite(
              id: reel.id,
              video: reel.video,
              author: reel.author,
              comments: reel.comments,
              isILiked: false,
              created_at: reel.created_at,
              numberOfLike: reel.numberOfLike! - 1,
            );
          }
          updatedReels.add(reel);
        }

        emit(GetAllReelLoadedState(reels: updatedReels));
      }
        },
        (success) {},
      );
    });
  }
}
