part of 'get_all_reel_bloc.dart';

sealed class GetAllReelEvent extends Equatable {
  const GetAllReelEvent();

  @override
  List<Object> get props => [];
}

class GetAllReelsEvent extends GetAllReelEvent {}