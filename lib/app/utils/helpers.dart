import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class Helpers {
  static exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  static showStatusBar({required bool show}) {
    if (show == true) {
      return SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
    return SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  static Future<Size> calculateImageDimension(String url) {
    Completer<Size> completer = Completer();
    Image image = Image.network(url);
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }

  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  static Color invertColor(Color color) {
    if (color == Color(0xffe10a0c) ||
        color == Color(0xff3ccbda) ||
        color == Color(0xFF710DB8)) {
      return Colors.white;
    }
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;
    return Color.fromARGB((color.opacity * 255).round(), r, g, b);
  }

  static statusBar({required bool show}) {
    if (show) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.bottom, // to hide only bottom bar
      ]);
    }
  }

  static String getCustomFormattedDateTime(
      {required DateTime givenDateTime, String? dateFormat}) {
    // dateFormat: 'dd/MM/yyyy H:mm:ss'
    String defaultFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    if (dateFormat != null) {
      return DateFormat(dateFormat).format(givenDateTime);
    }
    return DateFormat(defaultFormat).format(givenDateTime);
  }

  static int getDateTimeToInt({required String? timestamp}) {
    DateTime dt;
    if (timestamp != null) {
      dt = DateTime.parse(timestamp);
    } else {
      dt = DateTime.now();
    }
    return int.parse(dt.millisecondsSinceEpoch.toString().substring(0, 10));
  }

  static String getSaleOff(priceold, price) {
    double kq = 0;
    double chech = priceold! - price!;
    kq = chech / priceold * 100;
    return kq.floor().toString();
  }

  static Future<void> showNdDialog(BuildContext context,
      {bool fullscreen = false, required Widget widget}) {
    if (fullscreen == true) {
      return showGeneralDialog(
          context: context,
          barrierDismissible:
              true, // Dismiss dialog by clicking outside in current route
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.white, // Change dropshadow outside the dialog.
          transitionDuration:
              const Duration(milliseconds: 200), // Animation duration
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return widget;
          });
    }
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return widget;
        });
  }

  static dynamic getListMap(List<dynamic> items) {
    if (items == null) {
      return null;
    }
    List<Map<String, dynamic>> listItems = [];
    items.forEach((element) {
      listItems.add(element.toMap());
    });
    return listItems;
  }

  static String formatPrice(number, {String? unit}) {
    final formatCurrency =
         NumberFormat.currency(locale: 'vi_VN', symbol: unit ?? 'đ');
    return formatCurrency.format(number);
  }
}
