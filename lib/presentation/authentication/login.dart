import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:solidarity/bloc/auth/bloc/auth_bloc.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/authentication/register.dart';
import 'package:solidarity/presentation/bottom_navbar.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/extra_widgets.dart';
import 'package:solidarity/resources/fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: UserSimplePreferences.getEmail()??"");
  var passwordController = TextEditingController(text: UserSimplePreferences.getPassword()??"");
  bool remember = false;
  bool hide = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
         systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.grey, // Change the status bar color
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Container(
        height: size.height,
        width: size.width,
         decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(
                    "assets/images/splashi.png"
                  ),
                  fit: BoxFit.cover,opacity: 0.1
                  ),
                ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: size.height*0.16,
                    width: size.width,
                   
                    child: Center(child: 
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       DText(color: ColorManager.textColorBlack, text: "Welcome User", weight: FontWeightManager.semibold, size: FontSize.s30),
                       const SizedBox(
                        height: 5,
                       ),
                     DText(color: ColorManager.textColorBlack, text: "Please Login To Continue", weight: FontWeightManager.semibold, size: FontSize.s20),
                        const SizedBox(height: 10,)
                     ],
                   )
                    ),
                  ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextBox(
                          validation: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                          controller: emailController,
                          labelText: "Email",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextBox(
                          controller: passwordController,
                          labelText: "Password",
                          validation: (val) {
                            if (val.length != 3 && val.length < 3) {
                              return "Password is too short";
                            }
                            if (val == null || val.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          hide: hide,
                          icon: hide == true
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          tap: () {
                            hide == false ? hide = true : hide = false;
                            setState(() {});
                          },
                        ),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if(state is AuthLoginLoading){
                              DialogBox().dialogbox(context);
                            }
                            if(state is AuthLoginLoaded){
                              // Get.back();
                              print("success");
                              Get.offAll(()=>BottomNavigationPage());
                            }
                            if(state is AuthLoginError){
                              Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                                  ShowSnackBar().snack(
                                                      state.message, Colors.red));
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: ColorManager.primaryColor,
                                  value: UserSimplePreferences.getRemember()??false,
                                  onChanged: (val) {
                                    UserSimplePreferences.setRemember(val!);
                                    setState(() {});
                                  }),
                              DText(
                                  color: ColorManager.textColorBlack,
                                  text: "Remember me",
                                  weight: FontWeightManager.bold,
                                  size: FontSize.s14)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            AuthButton(
                              text: "Login",
                              tap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(AuthLoginEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim()));
                                } else {
                                  print("err");
                                }
                              },
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Icon(
                            //         Icons.fingerprint,
                            //         color: ColorManager.primaryColor,
                            //       ),
                            //       DText(
                            //           color: ColorManager.primaryColor,
                            //           text: "Login With Fingerprint",
                            //           weight: FontWeightManager.semibold,
                            //           size: FontSize.s15),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Align(
                        //     alignment: Alignment.centerRight,
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(right: 10),
                        //         child: DText(
                        //             color: ColorManager.boxBlue,
                        //             text: "Forgot Password ?",
                        //             weight: FontWeightManager.bold,
                        //             size: FontSize.s14),
                        //       ),
                        //     )),
                        const SizedBox(
                          height: 10,
                        ),
                         SizedBox(
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Divider(thickness: 2,color: ColorManager.primaryColor,)),
                                    DText(color: ColorManager.textColorBlack, text: "Or", weight: FontWeightManager.bold, size: FontSize.s14),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width*0.4,
                                      child: Divider(thickness: 2,color: ColorManager.primaryColor,)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DText(color: ColorManager.textColorBlack, text: "Continue with ", weight: FontWeightManager.bold,  size: FontSize.s14),
                                    GestureDetector(
                                      onTap: (){
                                        Get.off(Register());
                                      },
                                      child: DText(color: ColorManager.boxBlue, text: "Register", weight: FontWeightManager.bold,  size: FontSize.s14)),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
