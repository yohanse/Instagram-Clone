part of 'add_reel_bloc.dart';

sealed class AddReelEvent extends Equatable {
  const AddReelEvent();

  @override
  List<Object> get props => [];
}


class AddReelClick extends  AddReelEvent{
  final String filePath;
  final String content;
  const AddReelClick({
    required this.content,
    required this.filePath,
  });
}