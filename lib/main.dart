import 'package:flutter/material.dart';
import 'package:image_gallery_task/image_gallery/image_gallery_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            color: Colors.blueAccent,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      home: const ImageGalleryScreen(),
    );
  }
}
