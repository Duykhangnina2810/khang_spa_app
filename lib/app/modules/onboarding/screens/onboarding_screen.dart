import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/components/button/gf_button.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Đang là màn hình onboarding'),
            const SizedBox(
              height: 20,
            ),
            _BuildBtnSkip(),
          ],
        ),
      ),
    );
  }
}

class _BuildBtnSkip extends ConsumerWidget {
  const _BuildBtnSkip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GFButton(
      text: 'SKIP',
      textStyle: TextStyle(color: Colors.white),
      onPressed: () {

      },
    );
  }
}
