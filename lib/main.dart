import 'package:clean_flutter/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'POSTS',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('POSTS'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
