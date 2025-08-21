class Validators {
  static String? validateEmail(String? value, {bool validateCollege = true}) {
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    final regex = RegExp(pattern);
    final regexCollege = RegExp(r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]*ufg\.br$');
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Digite um email válido';
    }
    if (validateCollege && !regexCollege.hasMatch(value)) {
      return "O email precisa ser do domínio @ufg.br";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    const minLength = 8;
    if (value == null || value.isEmpty) {
      return 'Digite uma senha válida';
    }
    if (value.length < minLength) {
      return 'A senha deve ter pelo menos $minLength caracteres';
    }
    return null;
  }
}
