part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostEntite> post;
  const PostLoaded({required this.post});
}

class PostError extends PostState {
  final String message;
  const PostError({required this.message});
}