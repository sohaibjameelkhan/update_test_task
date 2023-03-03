import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_project/src/commonWidgets/custom_loader_widget.dart';
import 'package:test_project/src/configs/helpers/validator_helpoers.dart';
import 'package:test_project/src/modules/authenticationModule/providers/authentication_provider.dart';
import 'package:test_project/src/modules/authenticationModule/screens/signup_screen.dart';

import '../../../commonWidgets/button_widget.dart';
import '../../../commonWidgets/textfield_widget.dart';
import '../../../configs/utils/app_colors.dart';
import '../../../configs/utils/frontend_text_utils.dart';
import '../../../configs/utils/theme.dart';
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
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
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
                        FrontEndTextUtils.signIn,
                        style: fontW7S12(context)!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        FrontEndTextUtils.pleaseenteryourcredentials,
                        style: fontW3S12(context),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SocialButtonWidget(
                    text: FrontEndTextUtils.continueWithGoogle,
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
                            hintText: FrontEndTextUtils.email,
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
                          hintText: FrontEndTextUtils.password,
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
                      FrontEndTextUtils.forgotPassword,
                      style: fontW3S12(context)!.copyWith(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtonWidget(
                      horizontalPadding: 0,
                      text: FrontEndTextUtils.signIn,
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
                      text: FrontEndTextUtils.createAccount,
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
                          TextSpan(text: FrontEndTextUtils.bySigningIn),
                          TextSpan(
                              text: FrontEndTextUtils.termsAndCondition,
                              style: fontW4S12(context)!.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.appcolor)),
                          TextSpan(text: FrontEndTextUtils.and),
                          TextSpan(
                              text: FrontEndTextUtils.privacyPolicy,
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
