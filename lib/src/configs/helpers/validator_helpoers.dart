class ValidatorHelpers {
  static String emailRegx =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String userReg = r"^[a-zA-Z]+([,._]?[a-zA-Z]+)*$" "";

  static String newReg = r"^[a-zA-Z]+([,._]?[a-zA-Z]+)*$" "";

//[^#$%&'*+-/=?^_`{|}]
  static String aboutMe = r"[a-z A-Z]+[@!-,.]?[0-9]?";

  static String addressRegx = r"\d{1,5}\s\w.\s(\b\w*\b\s){1,2}\w*\.[0-9]";

  static String newAddress = r"A-Za-z0-9'\.\,\@\!,";

  static String newName = r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";

  static String? validateName(String? value) {
    //

    if (value?.isEmpty ?? true) {
      return "User name is required";
    }

    if (!RegExp(userReg).hasMatch(value!.trim().replaceAll(" ", ""))) {
      return "Please enter valid characters";
    }

    if (value.length < 3) {
      return "Name should grater than 3 characters";
    }

    if (value.length > 25) {
      return "only 25 characters are allow";
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Email should not be empty";
    }
    bool emailValid = RegExp(emailRegx).hasMatch(email);

    if (!emailValid) {
      return 'Please use valid email address';
    }
    if (email.length > 100) {
      return "not allow more than 100 characters";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Password";
    } else if (!RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        .hasMatch(value)) {
      return "Please Enter Strong Password";
    }
  }
}
