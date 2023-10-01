import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlidingImages extends StatelessWidget {
  const SlidingImages({Key? key, required this.imgUrls}) : super(key: key);
  final List<String>? imgUrls;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height / 3,
      width: width,
      child: Center(
        child: CarouselSlider.builder(
          itemCount: imgUrls!.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            String img = imgUrls![itemIndex];
            return CachedNetworkImage(
              fit: BoxFit.cover,
              width: double.infinity,
              imageUrl: img,
              placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/dash.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            );
          },
          options: CarouselOptions(
            height: height / 3,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
          ),
        ),
      ),
    );
  }
}
