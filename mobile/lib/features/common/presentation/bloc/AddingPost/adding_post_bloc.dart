import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/common/post/domain/entities/post_entitie.dart';
import 'package:mobile/features/common/post/domain/usecases/add_post.dart';

part 'adding_post_event.dart';
part 'adding_post_state.dart';

class AddingPostBloc extends Bloc<AddingPostEvent, AddingPostState> {
  final AddPostUseCase addPostUseCase;
  AddingPostBloc({required this.addPostUseCase}) : super(AddingPostInitial()) {
    on<AddPostEvent>((event, emit) async {
      emit(AddingPostLoadingState());
      var result = await addPostUseCase(
        ParamsAddPost(
          postEntite: PostEntite(
            images: event.images,
            text: event.text,
          ),
        ),
      );
      result.fold(
        (l) => emit(
          AddingPostErrorState(
            message: l.message,
          ),
        ),
        (r) => emit(
          AddingPostSuccessState(),
        ),
      );
    });
  }
}
