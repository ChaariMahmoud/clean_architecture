import 'package:clean_flutter/features%20/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUseCase {
  final PostRepository repository;

  GetAllPostsUseCase(this.repository);
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
