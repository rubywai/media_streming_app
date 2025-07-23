import 'package:flutter/material.dart';
import 'package:media_streming_app/movie_provider/movie_provider.dart';
import 'package:media_streming_app/page/movie_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MoviePage(),
      ),
    );
  }
}
