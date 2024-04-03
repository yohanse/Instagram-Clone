part of 'adding_post_bloc.dart';

sealed class AddingPostState extends Equatable {
  const AddingPostState();

  @override
  List<Object> get props => [];
}

final class AddingPostInitial extends AddingPostState {}

class AddingPostSuccessState extends AddingPostState {}

class AddingPostErrorState extends AddingPostState {
  final String message;

  const AddingPostErrorState({required this.message});
}

class AddingPostLoadingState extends AddingPostState {}
