extension StringExt on String{
    bool get isValidPassword {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return length > 7 && passwordRegExp.hasMatch(this);
  }
}