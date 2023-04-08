import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/l10n.dart';

class Loading {
  late BuildContext context;

  Loading(this.context);

  Future<void> start() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor:
              Colors.transparent, // can change this to your prefered color
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                const CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                const SizedBox(
                  height: 10,
                ),
                // Some text
                Text(
                  context.translate.vuilongdoi,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> stop() async {
    Navigator.of(context).pop();
  }
}
