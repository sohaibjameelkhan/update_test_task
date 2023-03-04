// This class is used as a base for custom exceptions
// It extends the built-in Exception class
class AppException implements Exception {
  final _message; // a private instance variable for storing the error message
  final _prefix; // a private instance variable for storing a prefix to the error message

  // a constructor for creating instances of the class
  // it takes an optional message and prefix parameter
  AppException([this._message, this._prefix]);

  // a method for converting the exception to a string
  // it returns the prefix followed by the message
  String toString() {
    return "$_prefix$_message";
  }
}

// This class is used for exceptions related to fetching data
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

// This class is used for exceptions related to invalid requests
class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

// This class is used for exceptions related to unauthorised access
class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

// This class is used for exceptions related to invalid input
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
