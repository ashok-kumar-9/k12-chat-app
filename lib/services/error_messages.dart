String getErrorMessage(String intent, String errorCode) {
  String errorMessage;
  if (intent == 'login') {
    switch (errorCode) {
      case "invalid-email":
        errorMessage = "Enter a valid email address";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "Email isn't registered";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "operaetion-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
  } else if (intent == 'reset') {
    switch (errorCode) {
      case "invalid-email":
        errorMessage = "Enter a valid email address";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "Email isn't registered";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "operaetion-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
  } else {
    switch (errorCode) {
      case "invalid-email":
        errorMessage = "Enter a valid email address";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "Email isn't registered";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "too-many-requests":
        errorMessage = "Too many requests. Try again later.";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case "email-already-in-use":
        errorMessage = "Email already registered. Try loggin in";
        break;
      case 'weak-password':
        errorMessage = "Password should be atleast 6 characters long";
        break;
      case 'network-request-failed':
        errorMessage = "Network error";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
  }
  return errorMessage;
}
