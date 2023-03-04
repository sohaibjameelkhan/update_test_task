import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  final double radius;
  final double? builderHeight;
  final double? builderWidth;

  const CacheNetworkImageWidget(
      {Key? key,
      required this.imgUrl,
      this.height,
      this.width,
      required this.radius,
      this.builderHeight = 90,
      this.builderWidth = 120})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) => Container(
        width: builderWidth,
        height: builderHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 1.2, color: Colors.white),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const SpinKitPulse(
        color: Colors.blue,
        size: 22,
        //    type: SpinKitWaveType.start
      ),
      errorWidget: (context, url, error) => Container(
        //strokeWidth: 0,
        height: builderHeight!,
        width: builderWidth!,
        //decoration: Boxed,
        child: Image.asset(
          "assets/images/useravatar.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
