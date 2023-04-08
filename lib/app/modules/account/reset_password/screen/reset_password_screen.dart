import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/form_reset_password/form_reset_password.dart';

import '../../../widgets/copyright_widget.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            FormResetPassword(),
          ],
        ),
      ),
      bottomNavigationBar: CopyrightWidget(),
    );
  }
}
