import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_task/image_gallery/pixabay_image_model.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  List<ImageFromPixabayModel> images = [];
  bool isLoading = false;
  int page = 1;
  final scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    getImages();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        imagePagination();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  void getImages() async {
    isLoading = true;
    update();
    // Uri url = Uri.parse(
    //     "https://pixabay.com/api/?key=43423427-d18dfaf92065a4742211d156e&per_page=32&page=$page");
    // http.Response response = await http.get(url);

    // var data = jsonDecode(response.body);
    var data = await imageApi(page);

    List hit = data['hits'];

    if (hit.isNotEmpty) {
      images = hit
          .map<ImageFromPixabayModel>((e) => ImageFromPixabayModel.fromJson(e))
          .toList();
      isLoading = false;
    } else {
      isLoading = false;
    }
    update();
    // print(images.length);
  }

  imageApi(int page) async {
    Uri url = Uri.parse(
        "https://pixabay.com/api/?key=43423427-d18dfaf92065a4742211d156e&per_page=36&page=$page");
    http.Response response = await http.get(url);

    return jsonDecode(response.body);
  }

  void imagePagination() async {
    page++;
    print(page);
    var data = await imageApi(page);
    List hit = data['hits'];
    if (hit.isNotEmpty) {
      images.addAll(hit
          .map<ImageFromPixabayModel>((e) => ImageFromPixabayModel.fromJson(e))
          .toList());
      update();
    }
  }
}
