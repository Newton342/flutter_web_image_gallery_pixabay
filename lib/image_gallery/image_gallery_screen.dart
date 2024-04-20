import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_task/image_gallery/image_controller.dart';
import 'package:image_gallery_task/image_gallery/image_view_screen.dart';

class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image gallery"),
      ),
      body: GetBuilder<ImageController>(
          init: ImageController(),
          builder: (ImageController controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: controller.images.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100.0,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.to(() => ImageViewScreen(
                              index: index,
                              imageUrl: controller.images[index].largeImageURL,
                            ));
                      },
                      child: Hero(
                        tag: index,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    controller.images[index].previewURL ?? "")),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.transparent,
                                    // Colors.transparent,
                                    Colors.black,
                                    Colors.black
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 12.0,
                                ),
                                const SizedBox(
                                  width: 1.5,
                                ),
                                Text(
                                  "${controller.images[index].likes}",
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 3.0,
                                ),
                                const Icon(
                                  Icons.comment_rounded,
                                  color: Colors.white,
                                  size: 12.0,
                                ),
                                const SizedBox(
                                  width: 1.5,
                                ),
                                Text(
                                  "${controller.images[index].comments}",
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
