import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  bool isDownloading = false;
  set _isDownloadingState(bool value) => setState(() => isDownloading = value);

  void downloadImage() async {
    var permission = await Permission.manageExternalStorage.status;
    if (permission.isDenied) {
      await Permission.manageExternalStorage.request();
    } else if (permission.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      String imagePath = "${widget.imageUrl?.split("/").last}";
      String path = "/storage/emulated/0/Download/$imagePath";
      File image = File(path);
      if (widget.imageUrl != null) {
        _isDownloadingState = true;
        if (!image.existsSync()) {
          http.Response response = await http.get(Uri.parse(widget.imageUrl!));
          await image.writeAsBytes(response.bodyBytes).whenComplete(
                () => viewSnackBar("File downloaded"),
              );
        } else {
          viewSnackBar("File already exists");
        }
        _isDownloadingState = false;
      }
    }
  }

  void viewSnackBar(String label) {
    final snackBar = SnackBar(
      content: Text(label),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 2000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: isDownloading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: LinearProgressIndicator(),
              )
            : null,
        title: const Text("Image"),
        actions: [
          !isDownloading
              ? IconButton(
                  onPressed: () => downloadImage(),
                  icon: const Icon(Icons.download))
              : const Offstage(),
        ],
      ),
      body: Center(
          child: Hero(
        tag: widget.index,
        child: Image.network(widget.imageUrl!,
            errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text("No image found"),
          );
        }, loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      )),
    );
  }
}
