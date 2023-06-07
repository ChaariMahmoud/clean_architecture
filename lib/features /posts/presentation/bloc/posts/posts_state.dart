part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostState extends PostsState {}

class LoadedPostState extends PostsState {
  final List<Post> posts;

  LoadedPostState({required this.posts});
  List<Object> get props => [posts];
}

class ErrorPosteState extends PostsState {
  final String message;

  ErrorPosteState({required this.message});
  List<Object> get props => [message];
}
