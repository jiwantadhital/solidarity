import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solidarity/bloc/auth/bloc/auth_bloc.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/authentication/choose_camera.dart';
import 'package:solidarity/presentation/authentication/login.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/extra_widgets.dart';
import 'package:solidarity/resources/fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey1 = GlobalKey<FormState>();
  String date = "";
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var addressController = TextEditingController();
  var occupationController = TextEditingController();
  var bioController = TextEditingController();
  String image = "";

  bool isFemale = false;
  bool remember = false;
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splashi.png"),
              fit: BoxFit.cover,
              opacity: 0.1),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.16,
                  width: size.width,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DText(
                          color: ColorManager.textColorBlack,
                          text: "Welcome User",
                          weight: FontWeightManager.semibold,
                          size: FontSize.s30),
                      const SizedBox(
                        height: 5,
                      ),
                      DText(
                          color: ColorManager.textColorBlack,
                          text: "Please Register To Continue",
                          weight: FontWeightManager.semibold,
                          size: FontSize.s20),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  )),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey1,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            controller: firstNameController,
                            labelText: "First Name",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                            },
                            controller: lastNameController,
                            labelText: "Last Name",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (val.length > 10) {
                                return 'Number cannot be greater than 10';
                              }
                            },
                            type: TextInputType.number,
                            controller: phoneController,
                            labelText: "Phone Number",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                             
                            },
                            type: TextInputType.emailAddress,
                            controller: emailController,
                            labelText: "Email",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            tap: (){
                              hide == true? hide = false:hide=true;
                              setState(() {
                                
                              });
                            },
                            hide: hide,
                            icon:hide == true? Icons.remove_red_eye:Icons.remove_red_eye_outlined,
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                            
                            },
                            type: TextInputType.text,
                            controller: passwordController,
                            labelText: "Password",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                             
                            },
                            type: TextInputType.text,
                            controller: addressController,
                            labelText: "Address",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthTextBox(
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                        
                            },
                            type: TextInputType.text,
                            controller: occupationController,
                            labelText: "Occupation",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DateOfBirth(
                            size: size,
                            text: date == "" ? "Date of birth" : date,
                            onTap: () {
                              showDatePicker(
                                      initialDate: DateTime.now(),
                                      context: context,
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 36500)),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                if (value != null) {
                                  date = DateFormat("dd/MM/yyyy").format(value);
                                  setState(() {});
                                }
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //for image
                          image == ""
                              ? DateOfBirth(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) {
                                          return CameraChoose(
                                            crop: true,
                                          );
                                        }).then((value) => {
                                          if (value != null)
                                            {
                                              image = value["imagePath"],
                                              setState(() {})
                                            }
                                        });
                                  },
                                  text: "Image Upload",
                                  size: size)
                              : Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: FileImage(File(image)))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          image = "";
                                          setState(() {});
                                        },
                                        child: DText(
                                            color: Colors.black,
                                            text: "Remove Image",
                                            weight: FontWeightManager.semibold,
                                            size: 15),
                                      )
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),

                          AuthTextBox(
                            maxLines: 4,
                            validation: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter some text';
                              }
                             
                            },
                            type: TextInputType.text,
                            controller: bioController,
                            labelText: "Bio",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _gender(),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthButton(
                            text: "Register",
                            tap: () {
                              if (_formKey1.currentState!.validate()) {
                                context.read<AuthBloc>().add(AuthRegisterEvent(
                                  imagePath: image, first_name: firstNameController.text,
                                   last_name: lastNameController.text,
                                    phone: phoneController.text,
                                     email: emailController.text,
                                    password: passwordController.text,
                                     address: addressController.text,
                                      dob: date,
                                     occupation: occupationController.text,
                                      bio: bioController.text,
                                      gender: isFemale==true?"Female":"Male"));
                              }
                              else{

                              }
                            },
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if(state is AuthReggisterLoading){
                                DialogBox().dialogbox(context);
                              }
                              if(state is AuthRegisterError){
                                Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                                  ShowSnackBar().snack(
                                                      state.message, Colors.red));
                              }
                              if(state is AuthregisterLoaded){
                                ScaffoldMessenger.of(context).showSnackBar(
                                                  ShowSnackBar().snack(
                                                      "Registered Successfully", Colors.green));
                              Get.offAll(()=>Login());
                              }
                            },
                            builder: (context, state) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          ),

                          SizedBox(
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Divider(
                                      thickness: 2,
                                      color: ColorManager.primaryColor,
                                    )),
                                DText(
                                    color: ColorManager.textColorBlack,
                                    text: "Or",
                                    weight: FontWeightManager.bold,
                                    size: FontSize.s14),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Divider(
                                      thickness: 2,
                                      color: ColorManager.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DText(
                                    color: ColorManager.textColorBlack,
                                    text: "Continue with ",
                                    weight: FontWeightManager.bold,
                                    size: FontSize.s14),
                                GestureDetector(
                                    onTap: () {
                                      Get.off(Login());
                                    },
                                    child: DText(
                                        color: ColorManager.boxBlue,
                                        text: "Login",
                                        weight: FontWeightManager.bold,
                                        size: FontSize.s14)),
                              ],
                            ),
                          )
                        ],
                      ),
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

//gender
  _gender() {
    return Row(
      children: [
        Checkbox(
            value: isFemale == true ? false : true,
            onChanged: (val) {
              isFemale == true ? isFemale = false : isFemale = true;
              setState(() {});
            }),
        DText(
            color: Colors.black,
            text: "Male",
            weight: FontWeightManager.semibold,
            size: 15),
        SizedBox(
          width: 20,
        ),
        Checkbox(
            value: isFemale == true ? true : false,
            onChanged: (val) {
              isFemale == true ? isFemale = false : isFemale = true;
              setState(() {});
            }),
        DText(
            color: Colors.black,
            text: "Female",
            weight: FontWeightManager.semibold,
            size: 15)
      ],
    );
  }
}

class DateOfBirth extends StatelessWidget {
  String text;
  void Function() onTap;
  DateOfBirth({
    super.key,
    required this.onTap,
    required this.text,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 55,
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: ColorManager.primaryColor),
            borderRadius: BorderRadius.circular(8)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: onTap,
            child: DText(
                color: ColorManager.primaryColor,
                text: text,
                weight: FontWeightManager.regular,
                size: 16),
          ),
        ),
      ),
    );
  }
}
