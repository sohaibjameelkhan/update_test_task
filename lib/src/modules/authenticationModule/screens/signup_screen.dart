import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_project/configs/helpers/validator_helpoers.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/sign_in_screen.dart';

import '../../../../configs/utils/app_colors.dart';
import '../../../../configs/utils/frontend_text_utils.dart';
import '../../../../configs/utils/theme.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../commonwidget/button_widget.dart';
import '../../../commonwidget/custom_loader_widget.dart';
import '../../../commonwidget/textfield_widget.dart';
import '../viewmodel/authentication_viewmodel.dart';
import '../widgets/social_button_widget.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/SignUpScreen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
        builder: (context, authProvider, __) {
      return CustomLoaderWidget(
        isLoading: authProvider.isLoading,
        widget: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/templogopng.png",
                          fit: BoxFit.cover,
                          height: 100,
                          width: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              FrontEndTextUtils.appName,
                              style: fontW4S12(context)!.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.createAccount.toString().tr(),
                        style: fontW7S12(context)!.copyWith(
                            fontWeight: FontWeight.w900, fontSize: 35),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SocialButtonWidget(
                    text: LocaleKeys.continueWithGoogle.toString().tr(),
                    icon: 'assets/images/googleicon.svg',
                    onTap: () {
                      authProvider.loginWithGoogle();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                            controller: emailController,
                            textFieldHeight: 50,
                            maxlines: 1,
                            showSuffixIcon: false,
                            toppadding: 18,
                            hintText: LocaleKeys.email.toString().tr(),
                            textInputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              return ValidatorHelpers.validateEmail(value);
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFieldWidget(
                            controller: nameController,
                            textFieldHeight: 50,
                            maxlines: 1,
                            showSuffixIcon: false,
                            toppadding: 18,
                            hintText: LocaleKeys.name.toString().tr(),
                            textInputType: TextInputType.name,
                            validator: (String? value) {
                              return ValidatorHelpers.validateName(value);
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFieldWidget(
                          controller: passwordController,
                          textFieldHeight: 50,
                          maxlines: 1,
                          showSuffixIcon: true,
                          toppadding: 18,
                          hintText: LocaleKeys.password.toString().tr(),
                          textInputType: TextInputType.visiblePassword,
                          onsuffixIconTap: () {
                            authProvider.visiblePasswordChange();
                          },
                          obsecureText: authProvider.showpasswordobsecure,
                          suffixIcon: authProvider.showpasswordobsecure == true
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: AppColors.appcolor,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: AppColors.appcolor,
                                ),
                          validator: (value) {
                            return ValidatorHelpers.validatePassword(value);
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFieldWidget(
                          controller: confirmPasswordController,
                          textFieldHeight: 50,
                          maxlines: 1,
                          showSuffixIcon: true,
                          toppadding: 18,
                          onsuffixIconTap: () {
                            authProvider.visibleConfirmPasswordChange();
                          },
                          obsecureText: authProvider.showconfirmobsecure,
                          suffixIcon: authProvider.showconfirmobsecure == true
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: AppColors.appcolor,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: AppColors.appcolor,
                                ),
                          hintText: LocaleKeys.confirmPassword.toString().tr(),
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Confirm Password";
                            } else if (value != passwordController.text) {
                              return "Password Not Matched";
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CommonButtonWidget(
                      horizontalPadding: 0,
                      text: LocaleKeys.createAccount.toString().tr(),
                      radius: 12,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.sendSignUpApiRequestProvider(
                              nameController.text,
                              emailController.text,
                              passwordController.text);
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonButtonWidget(
                      horizontalPadding: 0,
                      bordercolor: AppColors.greyColor.withOpacity(0.4),
                      backgroundcolor: AppColors.whitecolor,
                      textcolor: AppColors.blackColor,
                      text: LocaleKeys.signIn.toString().tr(),
                      radius: 12,
                      onTap: () {
                        GoRouter.of(context).go(SignInScreen.routeName);
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                      selectionColor: AppColors.appcolor,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  LocaleKeys.byCreatingAccount.toString().tr(),
                              style: TextStyle(fontSize: 13)),
                          TextSpan(
                              text: FrontEndTextUtils.termsAndCondition,
                              style: fontW4S12(context)!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appcolor)),
                          TextSpan(
                              text: LocaleKeys.and.toString().tr(),
                              style: TextStyle(fontSize: 13)),
                          TextSpan(
                              text: LocaleKeys.privacyPolicy.toString().tr(),
                              style: fontW4S12(context)!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appcolor)),
                        ],

                        style: fontW3S12(context),
                        spellOut: true,
                        //  text: FrontEndTextUtils.bySigningIn,
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
