import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_project/src/commonWidgets/button_widget.dart';
import 'package:test_project/src/configs/utils/app_colors.dart';
import 'package:test_project/src/modules/authenticationModule/providers/authentication_provider.dart';

import '../../../configs/helpers/hive_local_storage.dart';
import '../../../configs/utils/local_storage_text_utils.dart';
import '../../../configs/utils/theme.dart';
import 'managing_profile.dart';

class DashBoardScreen extends StatefulWidget {
  static String routeName = "/DashBoardScreen";

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String? userEmail;
  String? userToken;

  @override
  void initState() {
    loadLocalData();
    super.initState();
  }

  loadLocalData() async {
    userEmail = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userEmailBox,
          key: LocalStorageTextUtils.userEmailKey,
        ) ??
        '';
    userToken = await HiveLocalStorage.readHiveValue<String>(
          boxName: LocalStorageTextUtils.userTokenBox,
          key: LocalStorageTextUtils.userTokenKey,
        ) ??
        '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome : $userEmail",
            style: fontW4S12(context)!
                .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 50,
          ),
          userToken == null || userToken!.isEmpty
              ? const SizedBox()
              : CommonButtonWidget(
                  text: "My Profile",
                  backgroundcolor: AppColors.greyColor,
                  bordercolor: AppColors.greyColor,
                  textfont: 15,
                  onTap: () {
                    GoRouter.of(context).push(ManageProfile.routeName);
                    //  authenticationProvider.logoutFromApp(context);
                  }),
          const SizedBox(
            height: 15,
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
