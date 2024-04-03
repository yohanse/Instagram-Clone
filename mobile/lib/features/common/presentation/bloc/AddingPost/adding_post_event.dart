part of 'adding_post_bloc.dart';

sealed class AddingPostEvent extends Equatable {
  const AddingPostEvent();

  @override
  List<Object> get props => [];
}


class AddPostEvent extends AddingPostEvent {
  final String text;
  final List<String> images;

  const AddPostEvent({required this.text, required this.images});
}