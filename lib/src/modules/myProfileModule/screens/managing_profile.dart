import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_project/configs/utils/app_colors.dart';
import 'package:test_project/src/commonwidget/cached_network_widget.dart';

import '../../../../configs/utils/snackbar_utils.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../commonwidget/button_widget.dart';
import '../../../commonwidget/custom_loader_widget.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../widgets/manage_profile_txtfield.dart';

class ManageProfile extends StatefulWidget {
  static String routeName = "/ManageProfile";

  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final form = GlobalKey<FormState>();

  var userToken;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    initMethod();
    super.initState();
  }

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    countryController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  initMethod() async {
    await context.read<ProfileViewModel>().getUserProfileProvider();

    await setControllerValues();
  }

  setControllerValues() {
    emailController = TextEditingController(
        text: context.read<ProfileViewModel>().userProfileModel!.data!.email ??
            "");
    nameController = TextEditingController(
        text: context.read<ProfileViewModel>().userProfileModel!.data!.name ??
            "");
    phoneNoController = TextEditingController(
        text: context.read<ProfileViewModel>().userProfileModel!.data!.phone ??
            "");
    countryController = TextEditingController(
        text: context
            .read<ProfileViewModel>()
            .userProfileModel!
            .data!
            .country
            .toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context, userProfileProvider, __) {
      return CustomLoaderWidget(
        isLoading: userProfileProvider.isLoading,
        widget: WillPopScope(
          onWillPop: () async {
            userProfileProvider.croppedImage = null;

            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    userProfileProvider.croppedImage = null;
                    Navigator.maybePop(context);
                  },
                  child: Container(
                    height: 22,
                    width: 22,
                    child: const Card(
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: AppColors.appcolor,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                LocaleKeys.manageUserProfile.toString().tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            //backgroundColor: bckgroundclr,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: userProfileProvider.userProfileModel == null
                  ? const SpinKitPulse(
                      size: 5,
                      color: AppColors.appcolor,
                    )
                  : Column(
                      //padding: const EdgeInsets.only(left: 15, right: 15),
                      children: [
                        const SizedBox(height: 30),
                        Stack(
                          // clipBehavior: Clip.none,
                          // fit: StackFit.loose,
                          children: [
                            userProfileProvider.croppedImage != null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Image.file(
                                        File(userProfileProvider
                                            .croppedImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : CacheNetworkImageWidget(
                                    height: 100,
                                    width: 100,
                                    builderHeight: 100,
                                    builderWidth: 100,
                                    imgUrl:
                                        "https://racingeye.softlinks.ae/${userProfileProvider.userProfileModel!.data!.imagePath}",
                                    radius: 17),
                            Padding(
                              padding: const EdgeInsets.only(left: 80, top: 65),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: AppColors.appcolor),
                                child: IconButton(
                                    onPressed: () {
                                      userProfileProvider
                                          .showChoiceDialog(context);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: AppColors.whitecolor,
                                    )),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: form,
                          child: Column(
                            children: [
                              IgnorePointer(
                                child: ProfileTextFiled(
                                  hintText: "Please Enter Email",
                                  obs_text: false,
                                  controller: emailController,
                                  //lblTxt: 'Full Name',
                                  prefixIcn: Icons.email,
                                  // validator: (text) {
                                  //   if (!text!.isEmpty) {
                                  //     return "Enter email";
                                  //   }
                                  // },
                                ),
                              ),
                              ProfileTextFiled(
                                hintText: "Please Enter Name",
                                obs_text: false,
                                controller: nameController,
                                prefixIcn: Icons.person,
                              ),
                              // ProfileTextFiled(
                              //   ontap: () {
                              //     showCountryPicker(
                              //       context: context,
                              //       exclude: [],
                              //       showPhoneCode: true,
                              //       // optional. Shows phone code before the country name.
                              //       onSelect: (Country country) {
                              //         countryController.text = country.name;
                              //         //FocusScope.of(context).unfocus();
                              //         dp(
                              //             msg: "selected country",
                              //             arg: country.countryCode);
                              //       },
                              //     );
                              //   },
                              //   hintText: "country",
                              //   obs_text: false,
                              //   controller: countryController,
                              //   prefixIcn: Icons.flag,
                              // ),
                              ProfileTextFiled(
                                hintText: " Please Enter Phone Number",
                                obs_text: false,
                                controller: phoneNoController,
                                prefixIcn: Icons.phone,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        CommonButtonWidget(
                            text: LocaleKeys.updateProfile.toString().tr(),
                            horizontalPadding: 6,
                            textfont: 14,
                            onTap: () {
                              if (emailController.text.isEmpty) {
                                showErrorSnackBarMessage(
                                    content:
                                        "Please Enter Email Address To Update");
                              } else if (nameController.text.isEmpty) {
                                showErrorSnackBarMessage(
                                    content: "Please Enter Name To Update");
                              } else if (phoneNoController.text.isEmpty &&
                                  phoneNoController.text == null) {
                                showErrorSnackBarMessage(
                                    content: "Please Select Country To Update");
                              } else {
                                if (userProfileProvider.croppedImage == null) {
                                  userProfileProvider
                                      .updateWithOutImageProfileProvider(
                                          nameController.text,
                                          countryController.text,
                                          phoneNoController.text);
                                } else {
                                  userProfileProvider.updateProfileProvider(
                                      File(userProfileProvider
                                          .croppedImage!.path),
                                      nameController.text,
                                      countryController.text,
                                      phoneNoController.text);
                                }
                              }
                            })
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
