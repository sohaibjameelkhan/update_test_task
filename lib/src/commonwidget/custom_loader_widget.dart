
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../configs/utils/app_colors.dart';

class CustomLoaderWidget extends StatelessWidget {
  final bool isLoading;
  final Widget widget;

  const CustomLoaderWidget(
      {Key? key, required this.isLoading, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.1,
      progressIndicator: const SpinKitFadingCircle(
        size: 40,
        color: AppColors.appcolor,
      ),
      child: widget,
    );
  }
}
