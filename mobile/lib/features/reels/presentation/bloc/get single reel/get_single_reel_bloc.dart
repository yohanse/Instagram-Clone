import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_single_reel_event.dart';
part 'get_single_reel_state.dart';

class GetSingleReelBloc extends Bloc<GetSingleReelEvent, GetSingleReelState> {
  GetSingleReelBloc() : super(GetSingleReelInitial()) {
    on<GetSingleReelEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
