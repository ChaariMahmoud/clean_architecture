import 'package:clean_flutter/core/app_theme.dart' ;
import 'package:clean_flutter/features%20/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_flutter/features%20/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_flutter/features%20/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;



void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'POSTS',
        home: PostsPage()
      ),
    );
  }
}
