import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/usecase/get_reel.dart';

part 'get_single_reel_event.dart';
part 'get_single_reel_state.dart';

class GetSingleReelBloc extends Bloc<GetSingleReelEvent, GetSingleReelState> {
  final GetReelUseCase getReelUseCase;
  GetSingleReelBloc({required this.getReelUseCase})
      : super(GetSingleReelInitial()) {
    on<GetSingleReel>((event, emit) async {
     emit(GetSingleReelInProgress());
      var result =
          await getReelUseCase.call(ParamsGetReel(reelId: event.reelId));
      result.fold(
        (failure) => emit(GetSingleReelFailure(message: failure.message)),
        (reel) => emit(GetSingleReelSuccess(reel: reel)),
      );
    });
  }
}
