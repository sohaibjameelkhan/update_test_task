// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "appName": "Get Paid",
    "signIn": "Sign In",
    "pleaseenteryourcredentials": "Please enter your credentials",
    "sendedYouEmailAddress":
        "We’ll send a reset link on your registered email address.",
    "continueWithGoogle": "Continue with Google",
    "continueWithLinkedIn": "Continue with LinkedIn",
    "forgotPassword": "Forgot Password?",
    "createAccount": "Create Account",
    "bySigningIn": "By signing in you agree to our ",
    "termsAndCondition": "Terms and Conditions ",
    "and": "And ",
    "privacyPolicy": "Privacy Policy",
    "byCreatingAccount": "By creating account you agree to our ",
    "email": "Email",
    "name": "Name",
    "password": "Password",
    "confirmPassword": "Confirm Password",
    "confirmPhone": "Confirm Phone",
    "pleasecheckyourinboxforOTP": "Please check your inbox for OTP",
    "welcome": "Welcome",
    "translateToEnglish": "Translate To English",
    "translateToFrench": "Translate To French",
    "logOut": "LogOut",
    "myProfile": "My Profile",
    "manageUserProfile": "Manage User Profile",
    "updateProfile": "Update Profile",
    "chooseOption": "Choose Option",
    "gallery": "Gallery",
    "camera": "Camera"
  };
  static const Map<String, dynamic> fr = {
    "appName": "nom de l'application",
    "signIn": "S'identifier",
    "pleaseenteryourcredentials": "Please enter your credentials",
    "sendedYouEmailAddress": "Veuillez saisir vos identifiants",
    "continueWithGoogle": "Continuer avec Google",
    "continueWithLinkedIn": "Continue with LinkedIn",
    "forgotPassword": "Mot de passe oublié?",
    "createAccount": "Créer un compte",
    "bySigningIn": "En vous connectant, vous acceptez nos",
    "termsAndCondition": "Termes et conditions",
    "and": "Et ",
    "privacyPolicy": "politique de confidentialité",
    "byCreatingAccount": "En créant un compte, vous acceptez nos",
    "email": "E-mail",
    "name": "Nom",
    "password": "Mot de passe",
    "confirmPassword": "Confirmez le mot de passe",
    "confirmPhone": "Confirmer le téléphone",
    "pleasecheckyourinboxforOTP":
        "Veuillez vérifier votre boîte de réception pour OTP",
    "welcome": "Bienvenu",
    "translateToEnglish": "Traduire en anglais",
    "translateToFrench": "Traduire en français",
    "logOut": "Se déconnecter",
    "myProfile": "Mon profil",
    "manageUserProfile": "Gérer le profil utilisateur",
    "updateProfile": "Mettre à jour le profil",
    "chooseOption": "Choisissez une option",
    "gallery": "Galerie",
    "camera": "Caméra"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "fr": fr
  };
}
