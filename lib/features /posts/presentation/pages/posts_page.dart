import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/message_display_widget.dart';
import '../widgets/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(), body: _buildBody(),floatingActionButton: _buildFloatingBtn(), );
  }

  AppBar _buildAppbar() => AppBar(title: Text('Posts'));

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
          if (state is LoadingPostState) {
            return LoadingWidget();
          } else if (state is LoadedPostState) {
            PostListWidget(posts: state.posts);
          } else if (state is ErrorPosteState) {
            return MessageDisplayWidget(
              message: state.message,
            );
          }
          return LoadingWidget();
        }));
  }

  Widget _buildFloatingBtn() {
    return FloatingActionButton(onPressed: () {},child: Icon(Icons.add),);
  }
}
