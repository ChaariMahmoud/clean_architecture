import 'package:clean_flutter/features%20/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
