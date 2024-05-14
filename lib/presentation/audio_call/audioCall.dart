import 'package:flutter/material.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/resources/constants.dart';
import 'dart:math' as math;

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatefulWidget {
  String localUserId;
  String fId;
   AudioCallPage({super.key,required this.localUserId,required this.fId});

  @override
  State<AudioCallPage> createState() => _AudioCallPageState();
}

class _AudioCallPageState extends State<AudioCallPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: ZegoUIKitPrebuiltCall(appID: 
      ApiClass.appId, appSign: ApiClass.appSignIn,
       callID: widget.fId,
        userID: widget.localUserId,
         userName: "user_${widget.localUserId}",
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
          ),
    );
  }
}