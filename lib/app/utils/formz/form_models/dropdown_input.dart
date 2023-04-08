import 'package:flutter/cupertino.dart';
import '../../../../l10n/l10n.dart';

import '../formz.dart';

enum DropdownInputError { empty }

class DropdownInput extends FormzInput<String, DropdownInputError> {
  const DropdownInput.pure() : super.pure('');
  const DropdownInput.dirty([String value = '']) : super.dirty(value);

  @override
  DropdownInputError? validator(String value) {
    if (value.isEmpty) {
      return DropdownInputError.empty;
    }
    return null;
  }
}

extension extDropdownInput on DropdownInputError {
  String? getError(BuildContext context) {
    switch (this) {
      case DropdownInputError.empty:
        return context.translate.vuilongchonthongtin;
      default:
        return null;
    }
  }
}
