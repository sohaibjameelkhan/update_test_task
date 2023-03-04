import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_project/configs/helpers/validator_helpoers.dart';
import 'package:test_project/src/modules/authenticationmodule/screens/signup_screen.dart';
import 'package:test_project/src/modules/authenticationmodule/viewmodel/authentication_viewmodel.dart';
import 'package:test_project/translations/locale_keys.g.dart';

import '../../../../configs/utils/app_colors.dart';
import '../../../../configs/utils/frontend_text_utils.dart';
import '../../../../configs/utils/theme.dart';
import '../../../commonwidget/button_widget.dart';
import '../../../commonwidget/custom_loader_widget.dart';
import '../../../commonwidget/textfield_widget.dart';
import '../widgets/social_button_widget.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/SignInScreen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    height: 45,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.signIn.toString().tr(),
                        style: fontW7S12(context)!.copyWith(
                            fontWeight: FontWeight.w900, fontSize: 35),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        LocaleKeys.pleaseenteryourcredentials.tr(),
                        style: fontW3S12(context)!.copyWith(fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SocialButtonWidget(
                    text: LocaleKeys.continueWithGoogle.tr(),
                    icon: 'assets/images/googleicon.svg',
                    onTap: () {
                      authProvider.loginWithGoogle();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                            controller: emailController,
                            textFieldHeight: 55,
                            maxlines: 1,
                            showSuffixIcon: false,
                            toppadding: 12,
                            hintText: LocaleKeys.email.tr(),
                            textInputType: TextInputType.emailAddress,
                            validator: (String? value) {
                              return ValidatorHelpers.validateEmail(value);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          controller: passwordController,
                          textFieldHeight: 55,
                          maxlines: 1,
                          showSuffixIcon: true,
                          toppadding: 24,
                          hintText: LocaleKeys.password.tr(),
                          textInputType: TextInputType.emailAddress,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // toNext(
                      //     context: context,
                      //     widget: const ForgotPasswordScreen());
                    },
                    child: Text(
                      LocaleKeys.forgotPassword.tr(),
                      style: fontW3S12(context)!.copyWith(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtonWidget(
                      horizontalPadding: 0,
                      text: LocaleKeys.signIn.tr(),
                      radius: 12,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.sendLoginApiRequestProvider(
                              emailController.text, passwordController.text);
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
                      text: LocaleKeys.createAccount.tr(),
                      radius: 12,
                      onTap: () {
                        GoRouter.of(context).go(SignUpScreen.routeName);
                        // toRemoveAll(context: context, widget: SignUpScreen());
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
                              text: LocaleKeys.bySigningIn.tr(),
                              style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: LocaleKeys.termsAndCondition.tr(),
                              style: fontW4S12(context)!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appcolor)),
                          TextSpan(
                              text: LocaleKeys.and.tr(),
                              style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: LocaleKeys.privacyPolicy.tr(),
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
