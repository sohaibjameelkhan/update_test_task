import 'package:flutter/material.dart';

import '../../configs/helpers/theme_helper.dart';
import '../../configs/utils/app_colors.dart';

class CommonButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color textcolor;
  final Color bordercolor;
  final Color backgroundcolor;
  final double radius;
  final double buttonHeight;
  final double textfont;
  final double horizontalPadding;
  final double? buttonwidth;

  const CommonButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
    this.textcolor = Colors.white,
    this.bordercolor = AppColors.blackColor,
    this.backgroundcolor = AppColors.blackColor,
    this.radius = 9,
    this.buttonHeight = 55,
    this.buttonwidth,
    this.textfont = 17,
    this.horizontalPadding = 50,
    TextStyle? style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Container(
          height: buttonHeight,
          width: buttonwidth,
          decoration: BoxDecoration(
            color: backgroundcolor,
            border: Border.all(width: 1.5, color: bordercolor),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(
              text,
              style: fontW7S12(context)!.copyWith(
                  color: textcolor,
                  fontSize: textfont,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
