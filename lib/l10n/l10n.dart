// ignore_for_file: file_names
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get translate => AppLocalizations.of(this)!;
}

class L10n {
  // các ngôn ngữ hỗ trợ
  static final all = [
    const Locale('vi'),
    const Locale('en'),
  ];

  // lấy lá cờ theo ngôn ngữ
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'vi':
      default:
        return '🇻🇳';
    }
  }

  // lấy tên theo ngôn ngữ
  static String getNameLang(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'vi':
      default:
        return 'Vietnamese';
    }
  }
}
