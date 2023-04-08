import 'constants/app_settings.dart';
import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'core/router/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../_shared/routes_modules.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRouter.addGoRoute(newGoRoutes: modulesRoutes);
    // todo: Thay đổi ngôn ngữ const Locale('vi')
    // todo: Thay đổi theme => themeMode: ThemeMode.light or ThemeMode.dark
    return MaterialApp.router(
      title: AppSettings.nameApp,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.createGoRouter(),
    );
  }
}