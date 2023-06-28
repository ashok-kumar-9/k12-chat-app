String? validateEmail(text) {
  if (text.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
    return "Enter valid email address";
  }
  // return null if the text is valid
  return null;
}