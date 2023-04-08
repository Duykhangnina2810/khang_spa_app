import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/core/nd_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NdApp.init();
  runApp(
      UncontrolledProviderScope(
        container: NdApp.providerContainer,
        child: const App(),
      )
  );
}