import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/notification/local_notification.dart';
import 'package:solidarity/presentation/audio_call/audioCall.dart';
import 'package:solidarity/presentation/authentication/auth_page.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/presentation/bottom_navbar.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{

  final String localUserId = math.Random().nextInt(10000).toString();

  bool up = false;

  late Animation<double> animation;
  late AnimationController controller;
  Timer? _timer;

  fortrue(){
    up = true;
    setState(() {
      
    });
  }
  @override
  void initState() {     
    super.initState();
    _startDelay();
     FirebaseMessaging.instance.getToken().then((value) {
  
      if(value != null){
        UserSimplePreferences.setfId(value);
        print(value);
        log(value);
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        // localnotice.value = 0;
        print("FirebaseMessaging.instance.getInitialMessage");

        if (message != null) {
          print("New Notification");
          if (message.notification!.body != null) {
            //   Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => Notifications()),
            // );
          }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
          Get.to(()=>AudioCallPage(localUserId: localUserId,fId: UserSimplePreferences.getId()!=null?UserSimplePreferences.getId().toString():"444",));
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");

        if (message.notification != null) {

        }
      },
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  _startDelay(){
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1),)..forward().whenComplete(() {
     Timer(const Duration(seconds: 1), fortrue);
    });
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }
  _goNext(){
    
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return UserSimplePreferences.userLoggedIn()? BottomNavigationPage():Login();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: MediaQuery.of(context).size.height*0.35,
                child: ScaleTransition(
                  scale: animation,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(controller),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height*0.25,
                      child: const Image(
                        image: AssetImage(
                          "assets/images/splashi.png"
                          ),
                          ),
                    ),
                  ),
                ),
              ),
                      const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}