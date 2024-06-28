import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tak/controllers/auth_controller.dart';

import '../../../../core/data/models/user_model.dart';
import '../../../onboard/presentation/pages/onboarding.dart';
import '../../../profile/presentation/pages/change_password.dart';
import '../../../profile/presentation/pages/profile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.userModel});

  final UserModel? userModel;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text('Delete your account from Tak Estate'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  //       context.read<AuthBloc>().add(DeleteAccountEvent()),
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: IconTheme(
            data: Theme.of(context).iconTheme,
            child: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Divider(),
          ListTile(
            onTap: () {
              //context.push("/profile");
              Get.to(() => Profile(userModel: widget.userModel));
            },
            leading: const Icon(Icons.person),
            title: Text(
              "Update  Profile",
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    fontSize: 15.sp,
                  ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              //context.push("/change-password");
              Get.to(() => const ChangePassword());
            },
            leading: const Icon(Icons.lock),
            title: Text(
              "Change Password",
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    fontSize: 15.sp,
                  ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              //context.read<AuthBloc>().add(LogoutEvent());
              controller.logout();
              Get.offAll(() => const Onboarding());
            },
            leading: const Icon(
              Icons.logout,
              color: Color.fromARGB(255, 209, 33, 20),
            ),
            title: Text(
              "Log Out",
              style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 209, 33, 20),
                  ),
            ),
          ),
          const Divider(),
          // ListTile(
          //   onTap: () async => await _showMyDialog(),
          //   leading: const Icon(
          //     Icons.delete_rounded,
          //     color: Color.fromARGB(255, 209, 33, 20),
          //   ),
          //   title: Text(
          //     "Delete Account",
          //     style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
          //           fontSize: 15.sp,
          //           fontWeight: FontWeight.w800,
          //           color: const Color.fromARGB(255, 209, 33, 20),
          //         ),
          //   ),
          // )
        ],
      ),
    );
  }
}
