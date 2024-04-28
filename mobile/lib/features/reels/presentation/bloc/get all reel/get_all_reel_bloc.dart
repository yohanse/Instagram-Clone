import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/usecase/get_all_reels_usecase.dart';

part 'get_all_reel_event.dart';
part 'get_all_reel_state.dart';

class GetAllReelBloc extends Bloc<GetAllReelEvent, GetAllReelState> {
  final GetAllReelUseCase getAllReelUseCase;
  GetAllReelBloc({required this.getAllReelUseCase})
      : super(GetAllReelInitial()) {
    on<GetAllReelsEvent>((event, emit) async {
      emit(GetAllReelLoadingState());
      var result = await getAllReelUseCase(ParamsGetAllReel());
      result.fold((l) => emit(GetAllReelErrorState(message: l.message)),
          (r) => emit(GetAllReelLoadedState(reels: r)));
    });
  }
}
