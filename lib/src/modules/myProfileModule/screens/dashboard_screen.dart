import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/src/commonWidgets/button_widget.dart';
import 'package:test_project/src/configs/utils/app_colors.dart';
import 'package:test_project/src/modules/authenticationModule/providers/authentication_provider.dart';

import '../../../configs/utils/theme.dart';

class DashBoardScreen extends StatelessWidget {
  static String routeName = "/DashBoardScreen";

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "DashboardScreen",
            style: fontW4S12(context)!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<AuthenticationProvider>(
              builder: (context, authenticationProvider, __) {
            return CommonButtonWidget(
                text: "LogOut",
                backgroundcolor: AppColors.redColor,
                bordercolor: AppColors.redColor,
                textfont: 15,
                onTap: () {
                  authenticationProvider.logoutFromApp(context);
                });
          })
        ],
      ),
    );
  }
}
