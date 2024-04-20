import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({
    super.key,
    this.imageUrl,
    required this.index,
  });
  final String? imageUrl;
  final int index;

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  void downloadImage() async {
    print(widget.imageUrl?.split("/").last);
    var permission = await Permission.manageExternalStorage.status;
    if (permission.isDenied) {
      await Permission.manageExternalStorage.request();
    } else if (permission.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      final Directory? downloadsDir = await getDownloadsDirectory();

      String imagePath =
          "${downloadsDir?.path}${widget.imageUrl?.split("/").last}";
      print(imagePath);
      File image = File(imagePath);
      await image.create();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         downloadImage();
        //       },
        //       icon: const Icon(Icons.file_download_outlined))
        // ],
      ),
      body: Center(
        child: widget.imageUrl != null
            ? Hero(
                tag: widget.index,
                child: Image.network(widget.imageUrl!,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              )
            : const Text("No Image found"),
      ),
    );
  }
}
