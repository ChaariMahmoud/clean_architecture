import 'package:clean_flutter/core/error/exeptions.dart';
import 'package:clean_flutter/core/error/failures.dart';
import 'package:clean_flutter/core/network/network_info.dart';
import 'package:clean_flutter/features%20/posts/data/models/post_model.dart';
import 'package:clean_flutter/features%20/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return right(remotePosts);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getChachedPosts();
        return right(localPosts);
      } on EmptyCacheExeption {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);

    return await getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> getMessage(
      Future<Unit> Function() deleteOrupdateOradd) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrupdateOradd();
        return right(unit);
      } on ServerExeption {
        return left(ServerFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
