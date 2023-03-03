import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/utils/app_colors.dart';
import '../../../configs/utils/theme.dart';

class SocialButtonWidget extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onTap;

  const SocialButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
                width: 1, color: AppColors.greyColor.withOpacity(0.4))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(icon),
            Text(
              text,
              style: fontW4S12(context)!.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
