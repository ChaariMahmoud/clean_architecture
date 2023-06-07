import 'package:bloc/bloc.dart';
import 'package:clean_flutter/core/strings/messages.dart';
import 'package:clean_flutter/features%20/posts/domain/usecases/add_post.dart';
import 'package:clean_flutter/features%20/posts/domain/usecases/delete_post.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final DeletePostUseCase deletePost;
  final UpdatePostUseCase updatePost;
  AddDeleteUpdatePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState (message: mapFailureToMessage(failure)));
        }, (_) {
          emit(MessageAddDeleteUpdatePostState (message:ADD_SUCCESS_MESSAGE ));
        });

      } else if (event is DeletePostEvent) {
        final failureOrDoneMessage = await deletePost(event.post_Id);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState (message: mapFailureToMessage(failure)));
        }, (_) {
          emit(MessageAddDeleteUpdatePostState (message:DELETE_SUCCESS_MESSAGE ));
        });
      } else if (event is UpdatePostEvent) {
        final failureOrDoneMessage = await updatePost(event.post);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorAddDeleteUpdatePostState (message: mapFailureToMessage(failure)));
        }, (_) {
          emit(MessageAddDeleteUpdatePostState (message:UPDATE_SUCCESS_MESSAGE ));
        });
      } else {}
    });
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_Failure_MESSAGE;
     

      case OfflineFailure:
        return OFFLINE_Failure_MESSAGE;

      default:
        return "Unexpected Error";
    }
  }
}
