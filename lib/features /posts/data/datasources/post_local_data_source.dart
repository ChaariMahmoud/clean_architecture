import 'dart:convert';
import 'package:clean_flutter/core/error/exeptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_flutter/features%20/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getChachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPrefences;

  PostLocalDataSourceImpl({required this.sharedPrefences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((PostModel) => PostModel.toJson())
        .toList();
    sharedPrefences.setString(CACHED_POSTS, jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getChachedPosts() {
    final jsonString = sharedPrefences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheExeption();
    }
  }
}
