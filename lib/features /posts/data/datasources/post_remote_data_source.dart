import 'dart:convert';

import 'package:clean_flutter/core/error/exeptions.dart';
import 'package:clean_flutter/features%20/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel posteModel);
  Future<Unit> addPost(PostModel posteModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com/";

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("$BASE_URL/posts/"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else
      throw ServerExeption();
  }

  @override
  Future<Unit> addPost(PostModel posteModel) async {
    final body = {
      "title": posteModel.title,
      "body": posteModel.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> updatePost(PostModel posteModel) async {
    final postId = posteModel.id.toString();
    final body = {
      "title": posteModel.title,
      "body": posteModel.body,
    };
    final response =
        await client.patch(Uri.parse(BASE_URL + "/posts/$postId"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerExeption();
    }
  }
}
