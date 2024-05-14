import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solidarity/bloc/auth/bloc/auth_bloc.dart';
import 'package:solidarity/data/model/profile/profile_model.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/authentication/choose_camera.dart';
import 'package:solidarity/presentation/authentication/register.dart';
import 'package:solidarity/presentation/bottom_navbar.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/extra_widgets.dart';
import 'package:solidarity/resources/fonts.dart';

class EditProfilePage extends StatefulWidget {
  ProfileData profileData;
  EditProfilePage({super.key, required this.profileData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey2 = GlobalKey<FormState>();
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
  void initState() {
    firstNameController =
        TextEditingController(text: widget.profileData.firstName);
    lastNameController =
        TextEditingController(text: widget.profileData.lastName);
    phoneController = TextEditingController(text: widget.profileData.phone);
    emailController = TextEditingController(text: widget.profileData.email);
    addressController = TextEditingController(text: widget.profileData.address);
    occupationController =
        TextEditingController(text: widget.profileData.occupation);
    bioController =
        TextEditingController(text: widget.profileData.bioDescription);
    date = widget.profileData.dob.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: false,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(
            color: Colors.white,
            text: "Edit Profile",
            weight: FontWeightManager.semibold,
            size: 18),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey2,
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
                          },
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          labelText: "Email",
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
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if(state is ProfileEditing){
                                DialogBox().dialogbox(context);
                              }
                              if(state is EditError){
                                Get.back();
                              ScaffoldMessenger.of(context).showSnackBar(
                                                  ShowSnackBar().snack(
                                                      state.message, Colors.red));
                              }
                              if(state is ProfileEdited){
                                ScaffoldMessenger.of(context).showSnackBar(
                                                  ShowSnackBar().snack(
                                                      "Registered Successfully", Colors.green));
                              Get.offAll(()=>BottomNavigationPage());
                              }
                          },
                          builder: (context, state) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                        _gender(),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthButton(
                          text: "Edit",
                          tap: () {
                            if (_formKey2.currentState!.validate()) {
                              context.read<AuthBloc>().add(ProfileEditingEvent(
                                  first_name: firstNameController.text,
                                  last_name: lastNameController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                  dob: date,
                                  gender:
                                      isFemale == true ? "Female" : "Male"));
                            } else {}
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
