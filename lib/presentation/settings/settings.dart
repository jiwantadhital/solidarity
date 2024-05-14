import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/auth_page.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: Colors.grey[200],
      appBar: AppBar(
        forceMaterialTransparency: false,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(color: Colors.white, text: "Settings", weight: FontWeightManager.semibold, size: 18),
      ),
      body: Container(
        child: Column(
          children: [
       
            SettingsBox(size: size,name: "Logout",icon: Icons.logout,
            tap:(){
              UserSimplePreferences.logout().then((value) {
                Get.offAll(Login());
              });
            },
            ),

          ],
        ),
      ),
    );
  }
}

class SettingsBox extends StatelessWidget {
  String name;
  IconData icon;
  void Function() tap;
   SettingsBox({
    super.key,
    required this.tap,
    required this.size,
    required this.name,
    required this.icon
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(top: 5,bottom: 5),
                width: size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 Row(
                  children: [
                      Icon(icon),
                    SizedBox(width: 10,),
                     DText(color: Colors.black, text: name, weight: FontWeightManager.medium, size: 16),
                  ],
                 ),
                 Icon(Icons.arrow_forward_ios,size: 18,)
                  ],
                ),
            ),
    );
  }
}