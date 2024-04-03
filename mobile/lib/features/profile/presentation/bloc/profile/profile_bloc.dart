import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/profile/Domain/Usecase/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  ProfileBloc({required this.getProfileUsecase}) : super(ProfileInitial()) {
    on<GetProfileDetailEvent>((event, emit) async {
      emit(ProfileLoadingState());
      var result = await getProfileUsecase(ParamsGetProfile());
      result.fold(
        (l) => emit(ProfileErrorState()),
        (r) => emit(
          ProfileLoadedState(name: r.name, profileImage: r.profile_image),
        ),
      );
    });
  }
}
