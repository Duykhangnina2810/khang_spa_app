import 'package:flutter/cupertino.dart';
import '../../../../l10n/l10n.dart';

import '../formz.dart';

enum PasswordInputError { empty, passMin }

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty;
    }
    if (value.length < 6) {
      return PasswordInputError.passMin;
    }
    return null;
  }
}

extension extPasswordInput on PasswordInputError {
  String? getError(BuildContext context) {
    switch (this) {
      case PasswordInputError.empty:
        return context.translate.vuilongdienthongtin;
      case PasswordInputError.passMin:
        return context.translate.matkhaungan(6);
      default:
        return null;
    }
  }
}
