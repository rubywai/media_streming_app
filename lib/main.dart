import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:provider/provider.dart';

import 'movie_provider/movie_provider.dart';
import 'page/movie_page.dart';
import 'utils/device_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isDeviceTv = await isDeviceAndroidTV();
  GetIt.I.registerSingleton<bool>(isDeviceTv);
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
