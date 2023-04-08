import 'package:flutter/cupertino.dart';
import '../../../../l10n/l10n.dart';

import '../formz.dart';

enum RePasswordInputError { empty, mismatch }

class RePasswordInput extends FormzInput<String, RePasswordInputError> {
  final String? password;

  const RePasswordInput.pure({this.password = ''}) : super.pure('');

  const RePasswordInput.dirty(super.value, this.password) : super.dirty();

  @override
  RePasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return RePasswordInputError.empty;
    }
    if (password != value) {
      return RePasswordInputError.mismatch;
    }
    return null;
  }
}

extension extRePasswordInput on RePasswordInputError {
  String? getError(BuildContext context) {
    switch (this) {
      case RePasswordInputError.empty:
        return context.translate.vuilongdienthongtin;
      case RePasswordInputError.mismatch:
        return context.translate.nhaplaimatkhaukhongdung;
      default:
        return null;
    }
  }
}
