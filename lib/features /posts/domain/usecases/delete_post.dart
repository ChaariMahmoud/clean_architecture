import 'package:clean_flutter/features%20/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
