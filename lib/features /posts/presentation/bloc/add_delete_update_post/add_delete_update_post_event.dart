part of 'add_delete_update_post_bloc.dart';

abstract class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  AddPostEvent({required this.post});
  List<Object> get props => [post];
}

class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int post_Id;

  DeletePostEvent({required this.post_Id});
  List<Object> get props => [post_Id];
}

class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});
  List<Object> get props => [post];
}
