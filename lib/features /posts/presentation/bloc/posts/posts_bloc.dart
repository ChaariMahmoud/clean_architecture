import 'package:bloc/bloc.dart';
import 'package:clean_flutter/core/strings/failures.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostState());
        final failureOrPosts = await getAllPosts.call();
        failureOrPosts.fold((failure) {
          emit(ErrorPosteState(message: mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPostState(posts: posts));
        });
      }
    });
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_Failure_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_Failure_MESSAGE;

      case OfflineFailure:
        return OFFLINE_Failure_MESSAGE;

      default:
        return "Unexpected Error";
    }
  }
}
