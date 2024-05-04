import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/reels/domain/Entitie/reel_entitie.dart';
import 'package:mobile/features/reels/domain/usecase/add_reel_usecase.dart';

part 'add_reel_event.dart';
part 'add_reel_state.dart';

class AddReelBloc extends Bloc<AddReelEvent, AddReelState> {
  final AddReelUseCase addReelUseCase;
  AddReelBloc({required this.addReelUseCase}) : super(AddReelInitial()) {
    on<AddReelClick>((event, emit) async {
      emit(AddReelLoading());
      var result = await addReelUseCase(
        ParamsAddReel(
          filePath: event.filePath,
          content: event.content,
        ),
      );
      result.fold(
        (failure) => emit(
          AddReelError(
            message: failure.message,
          ),
        ),
        (reel) => emit(
          AddReelSuccess(
            reelEntite: reel,
          ),
        ),
      );
    });
  }
}
