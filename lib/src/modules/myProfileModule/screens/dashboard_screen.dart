import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_project/configs/helpers/theme_helper.dart';
import 'package:test_project/configs/utils/app_colors.dart';
import 'package:test_project/src/modules/authenticationmodule/viewmodel/authentication_viewmodel.dart';

import '../../../../configs/helpers/hive_local_storage.dart';
import '../../../../configs/utils/local_storage_text_utils.dart';
import '../../../../configs/utils/theme.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../commonwidget/button_widget.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${LocaleKeys.welcome.toString().tr()} : $userEmail",
                style: fontW4S12(context)!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          userToken == null || userToken!.isEmpty
              ? const SizedBox()
              : CommonButtonWidget(
                  text: LocaleKeys.myProfile.toString().tr(),
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
          CommonButtonWidget(
              text: LocaleKeys.translateToEnglish.toString().tr(),
              backgroundcolor: AppColors.appcolor,
              bordercolor: AppColors.appcolor,
              textfont: 15,
              onTap: () async {
                await context.setLocale(Locale("en"));
                //  authenticationProvider.logoutFromApp(context);
              }),
          const SizedBox(
            height: 15,
          ),
          CommonButtonWidget(
              text: LocaleKeys.translateToFrench.toString().tr(),
              backgroundcolor: AppColors.blackColor,
              bordercolor: AppColors.blackColor,
              textfont: 15,
              onTap: () async {
                await context.setLocale(Locale("fr"));
                //  authenticationProvider.logoutFromApp(context);
              }),
          const SizedBox(
            height: 15,
          ),
          Consumer<ThemeProvider>(builder: (context, themeProvider, __) {
            return CommonButtonWidget(
                text: 'Switch to ${themeProvider.currentType.name} theme',
                backgroundcolor: AppColors.blackColor,
                bordercolor: AppColors.blackColor,
                textfont: 15,
                onTap: () async {
                  themeProvider.toggleTheme();
                  //await context.setLocale(Locale("fr"));
                  //  authenticationProvider.logoutFromApp(context);
                });
          }),
          const SizedBox(
            height: 15,
          ),
          Consumer<AuthenticationViewModel>(
              builder: (context, authenticationProvider, __) {
            return CommonButtonWidget(
                text: LocaleKeys.logOut.toString().tr(),
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
