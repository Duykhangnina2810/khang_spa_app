import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/provider/auth_controller.dart';
import '../../../widgets/must_signin_widget.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider).authStatus;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: false,
      ),
      body: (authStatus != AuthStatus.authenticated)
          ? const MustSignInWidget()
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                ProfileAvatar(),
                const SizedBox(height: 10.0),
                ProfileInfo(),
                const SizedBox(height: 20.0),
                BuildLogOut(),
                const SizedBox(height: 30.0),
              ]),
            )),
    );
  }
}

class BuildLogOut extends ConsumerWidget {
  const BuildLogOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(authProvider.notifier).onSignOut();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Đăng xuất'.toUpperCase(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
