import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:tak/core/widgets/tak_along_drawer.dart';
import 'package:tak/features/home/presentation/pages/home.dart';
import 'package:tak/features/messages/presentation/pages/messages.dart';
import 'package:tak/features/notification/presentation/pages/notifications.dart';
import 'package:tak/features/transactions/presentation/pages/transactions.dart';

import '../../controllers/auth_controller.dart';
import '../utils/colors.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: HeroIcon(
      HeroIcons.home,
      size: 20.r,
    ),
    label: 'Home',
    activeIcon: HeroIcon(
      HeroIcons.home,
      size: 20.r,
      color: primaryColor,
    ),
  ),
  BottomNavigationBarItem(
    icon: HeroIcon(
      HeroIcons.chartBar,
      size: 20.r,
    ),
    label: 'Transactions',
    activeIcon: HeroIcon(
      HeroIcons.chartBar,
      size: 20.r,
      color: primaryColor,
    ),
  ),
  BottomNavigationBarItem(
    // icon: badges.Badge(
    //   badgeContent: Text(
    //     '0',
    //     style: GoogleFonts.robotoFlex(
    //       color: white,
    //     ),
    //   ),
    //   child: HeroIcon(
    //     HeroIcons.chatBubbleBottomCenter,
    //     size: 20.r,
    //   ),
    // ),
    icon: HeroIcon(
      HeroIcons.chatBubbleBottomCenter,
      size: 20.r,
    ),
    label: 'Messages',
    activeIcon: HeroIcon(
      HeroIcons.chatBubbleBottomCenter,
      size: 20.r,
      color: primaryColor,
    ),

    //     activeIcon: badges.Badge(
    //   badgeContent: Text(
    //     '0',
    //     style: GoogleFonts.robotoFlex(
    //       color: white,
    //     ),
    //   ),
    //   child: HeroIcon(
    //     HeroIcons.chatBubbleBottomCenter,
    //     size: 20.r,
    //     color: primaryColor,
    //   ),
    // ),
  ),
  BottomNavigationBarItem(
    icon: HeroIcon(
      HeroIcons.bell,
      size: 20.r,
    ),
    // icon: badges.Badge(
    //   badgeContent: Text(
    //     '0',
    //     style: GoogleFonts.robotoFlex(
    //       color: white,
    //     ),
    //   ),
    //   child: HeroIcon(
    //     HeroIcons.bell,
    //     size: 20.r,
    //   ),
    // ),
    label: 'Notifications',
    // activeIcon: badges.Badge(
    //   badgeContent: Text(
    //     '0',
    //     style: GoogleFonts.robotoFlex(
    //       color: white,
    //     ),
    //   ),
    //   child: HeroIcon(
    //     HeroIcons.bell,
    //     size: 20.r,
    //     color: primaryColor,
    //   ),
    // ),
    activeIcon: HeroIcon(
      HeroIcons.bell,
      size: 20.r,
      color: primaryColor,
    ),
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  Home(),
  Transactions(),
  Messages(),
  Notifications(),
];

class TakBottomNavigation extends StatefulWidget {
  const TakBottomNavigation({super.key});

  @override
  State<TakBottomNavigation> createState() => _TakBottomNavigationState();
}

class _TakBottomNavigationState extends State<TakBottomNavigation> {
  int currentPageIndex = 0;
  final bool isHomeScreen = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    controller.getUserData();

    return Scaffold(
      body: bottomNavScreen.elementAt(currentPageIndex),
      drawer: const Drawer(
        child: TakDrawer(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        items: bottomNavItems,
        currentIndex: currentPageIndex,
        selectedItemColor: primaryColor,
        selectedFontSize: 14.sp,
        unselectedFontSize: 14.sp,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context).add(
        //   TabChange(index: index),
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
