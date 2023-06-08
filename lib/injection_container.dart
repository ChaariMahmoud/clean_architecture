import 'package:clean_flutter/features%20/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_flutter/features%20/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_flutter/features%20/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_flutter/features%20/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_flutter/features%20/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features /posts/data/datasources/post_local_data_source.dart';
import 'features /posts/domain/repositories/posts_repository.dart';
import 'features /posts/domain/usecases/add_post.dart';
import 'features /posts/domain/usecases/delete_post.dart';
import 'features /posts/domain/usecases/update_post.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - posts

  //Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  //Repositories

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //Datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPrefences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
