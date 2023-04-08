import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/device_info.dart';
import 'local_storage/app_storage.dart';

class NdApp {
  static final localStorage = AppStorage();
  static final deviceInfoPlugin = DeviceInfoPlugin();
  static late Map<String, dynamic> deviceInfo;
  static final providerContainer = ProviderContainer();
  static Future init() async {
    await localStorage.init();
    deviceInfo = await DeviceInfo.readDeviceInfo();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
  }
}
