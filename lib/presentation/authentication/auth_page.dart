// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/presentation/authentication/register.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/fonts.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool loginselected = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
       decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.primaryColor, 
             Colors.grey[200]!,
        ])
       ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: 
              Container(
                height: size.height*0.32,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                    "assets/images/splashi.png"
                  ),
                  fit: BoxFit.cover,opacity: 0.1
                  ),
                ),
                child: Center(child: 
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   DText(color: ColorManager.textColorWhite, text: "Welcome User", weight: FontWeightManager.semibold, size: FontSize.s30),
                   const SizedBox(
                    height: 5,
                   ),
                  loginselected==true?DText(color: ColorManager.textColorWhite, text: "Please Create Your Account", weight: FontWeightManager.semibold , size: FontSize.s20):  DText(color: ColorManager.textColorWhite, text: "Please Login To Continue", weight: FontWeightManager.semibold, size: FontSize.s20),
                    const SizedBox(height: 40,)
                 ],
               )
                ),
              )
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.19,
                    width: MediaQuery.of(context).size.width,
                   
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 60),
                        height: MediaQuery.of(context).size.height*0.74,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                        ),
                        child: loginselected==false? const Login():const Register()
                      ),
                        Positioned(
                child: SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){
                          loginselected = false;
                          setState(() {
                            
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: loginselected == false? 60 : 55,
                          width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                                     color: loginselected == true?ColorManager.boxGreen: ColorManager.boxBlue,
                                     border: Border.all(width: 4,color: Colors.white)
                               ),
                               child: Center(
                                child: DText(color: ColorManager.textColorWhite, text: "Login", weight: FontWeightManager.semibold,size: FontSize.s16),
                               ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          loginselected = true;
                          setState(() {
                            
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: loginselected == false? 55 :60 ,
                          width: 130,
                            decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                                        color: loginselected == false? ColorManager.boxGreen : ColorManager.boxBlue,
                                        border: Border.all(width: 4,color: Colors.white)
                                      ),
                                      child: Center(
                                child: DText(color: ColorManager.textColorWhite, text: "Register", weight: FontWeightManager.semibold,  size: FontSize.s16),
                               ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                    ],
                  ),
        ),
              ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

