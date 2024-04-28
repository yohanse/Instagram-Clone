import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecase/like_reel_usecase.dart';

part 'like_reel_event.dart';
part 'like_reel_state.dart';

class LikeReelBloc extends Bloc<LikeReelEvent, LikeReelState> {
  final LikeReelUseCase likeReelUseCase;
  LikeReelBloc({required this.likeReelUseCase}) : super(LikeReelInitial()) {
    on<LikeReel>((event, emit) async {
      emit(LikeReelInProgress());
      var result = await likeReelUseCase.call(ParamsLikeReel(reelId: event.reelId));
      result.fold(
        (failure) => emit(LikeReelFailure(message: failure.message)),
        (success) => emit(LikeReelSuccess()),
      );
    });
  }
}
