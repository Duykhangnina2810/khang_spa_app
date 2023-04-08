import 'package:flutter/cupertino.dart';
import '../../../../l10n/l10n.dart';

import '../formz.dart';

enum EmailInputError { empty, invalid }

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  bool validateEmailAddress(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.empty;
    }
    if (!validateEmailAddress(value)) {
      return EmailInputError.invalid;
    }
    return null;
  }
}

extension extEmailInput on EmailInputError {
  String? getError(BuildContext context) {
    switch (this) {
      case EmailInputError.empty:
        return context.translate.vuilongdienthongtin;
      case EmailInputError.invalid:
        return context.translate.emailkhongdungdinhdang;
      default:
        return null;
    }
  }
}
