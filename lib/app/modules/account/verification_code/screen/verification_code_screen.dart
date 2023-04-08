import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/copyright_widget.dart';
import '../widgets/form_verification_code/form_verification_code.dart';

class VerificationCodeScreen extends ConsumerWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: const [
            FormVerificationCode(),
          ],
        ),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
