import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/message/Domain/usecase/get_messages_usecase.dart';

import '../../../Domain/entitie/message_entitie.dart';

part 'fetch_messages_event.dart';
part 'fetch_messages_state.dart';

class FetchMessagesBloc extends Bloc<FetchMessagesEvent, FetchMessagesState> {
  final GetMessagesUsecase getMessagesUsecase;
  FetchMessagesBloc({required this.getMessagesUsecase})
      : super(FetchMessagesInitial()) {
    on<GetMessagesEvent>((event, emit) async {
      emit(FetchMessagesLoadingState());
      var result = await getMessagesUsecase(
        ParamsGetMessages(
          receiverId: event.recieverId,
        ),
      );
      result.fold(
          (failure) => emit(FetchMessagesErrorState(message: failure.message)),
          (messages) => emit(FetchMessagesLoadedState(messages: messages)));
    });
  }
}
