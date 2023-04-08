import 'package:flutter/cupertino.dart';
import '../../../../l10n/l10n.dart';

import '../formz.dart';

enum TextInputError { empty }

class TextInput extends FormzInput<String, TextInputError> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty([String value = '']) : super.dirty(value);

  @override
  TextInputError? validator(String value) {
    if (value.isEmpty) {
      return TextInputError.empty;
    }
    return null;
  }
}

extension extTextInput on TextInputError {
  String? getError(BuildContext context) {
    switch (this) {
      case TextInputError.empty:
        return context.translate.vuilongdienthongtin;
      default:
        return null;
    }
  }
}
