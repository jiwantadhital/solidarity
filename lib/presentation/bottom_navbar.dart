import 'package:bottom_indicator_bar_svg/bottom_indicator_bar_svg.dart';
import 'package:flutter/material.dart';
import 'package:solidarity/presentation/chat/before_chat_page.dart';
import 'package:solidarity/presentation/profile/profile.dart';
import 'package:solidarity/presentation/requests/find_new_friends.dart';
import 'package:solidarity/presentation/settings/settings.dart';


class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationPage> {
  List pages = [
    ProfilePage(),
    BeforeChatPage(),
    FindNewFriendsPage(),
    SettingsPage(),
      ];

  int currentIndex = 0;
  callApis(){
  }
  @override
  void initState() {
    super.initState();
    
  }
  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (currentIndex == 0) {
          } else if (currentIndex != 0) {
            setState(() {});
            onTap(0);
          }
          return false;
        },
        child: Scaffold(
            body: pages[currentIndex],
            bottomNavigationBar:  BottomIndicatorBar(
                  barHeight: 60,
                  backgroundColor: Colors.white,
                  onTap: onTap,
                  currentIndex: currentIndex,
                  activeColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  inactiveColor: Colors.black,
                  items: [
                    BottomIndicatorNavigationBarItem(
                        label: 'Profile',
                        icon: "assets/images/home.svg",
                        iconSize: 24),
                    BottomIndicatorNavigationBarItem(
                        label: 'Messages',
                        icon: "assets/images/accounts.svg",
                        iconSize: 24),
                    BottomIndicatorNavigationBarItem(
                        label: 'Requests',
                        icon: "assets/images/qrcode.svg",
                        iconSize: 24),
                    
                    BottomIndicatorNavigationBarItem(
                        label: 'Settings',
                        icon: "assets/images/manage.svg",
                        iconSize: 24),
                  ],
                ),));
  }
}
