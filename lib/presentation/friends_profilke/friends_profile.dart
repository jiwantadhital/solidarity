import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solidarity/bloc/profile/bloc/profile_bloc.dart';
import 'package:solidarity/bloc/profile/category/bloc/category_bloc.dart';
import 'package:solidarity/bloc/profile/friends/bloc/friends_bloc.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:solidarity/resources/fonts.dart';

class FriendProfilePage extends StatefulWidget {
  int id;
   FriendProfilePage({super.key,required this.id});

  @override
  State<FriendProfilePage> createState() => _FriendProfilePageState();
}

class _FriendProfilePageState extends State<FriendProfilePage> {
  int? currentindex;
  String name = "";

  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryGettingEvent());
    context
        .read<ProfileBloc>()
        .add(ProfileGettingEvent(id: widget.id));
  context.read<FriendsBloc>().add(ByCategoryFriendsGettingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(color: Colors.white, text: name, weight: FontWeightManager.semibold, size: 16),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _topSection(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Container(
                    //     padding: EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //       color: ColorManager.primaryColor,
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(width: 2,color: Colors.white)
                    //     ),
                    //     child: Center(
                    //       child: DText(color: Colors.white,
                    //        text:
                    //        widget.sentRequest==true?"Cancel Request":
                    //         "Send Request", weight: FontWeightManager.medium, size: 13),
                    //     ),
                    //   ),
                    // ),
                    //friends list
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DText(
                          color: Colors.black,
                          text: "Friends",
                          weight: FontWeightManager.semibold,
                          size: 18),
                    ),
                    // Divider(),
                    BlocConsumer<FriendsBloc, FriendsState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if(state is FriendsLoading){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(state is Friendserror){
                          return Center(child: Text("Something went wrong"),);
                        }
                        if(state is FriendsLoaded){
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.profileFriendsModel.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                width: size.width,
                                decoration: BoxDecoration(color: Colors.white),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: ColorManager.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.grey[300]!),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${ApiClass.mainApi}/${state.profileFriendsModel.data![index].networkFriend!.imageUrl}"),
                                              fit: BoxFit.cover)),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DText(
                                            color: Colors.black,
                                            text: "${state.profileFriendsModel.data![index].networkFriend!.firstName} ${state.profileFriendsModel.data![index].networkFriend!.lastName}",
                                            weight: FontWeightManager.medium,
                                            size: 16),
                                        DText(
                                            color: Colors.black,
                                            text: state.profileFriendsModel.data![index].networkFriend!.phone??"",
                                            weight: FontWeightManager.regular,
                                            size: 14),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                        }
                        return Center(child: Text("something went wrong"),);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _topSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if(state is ProfileLoaded){
                  name = "${state.profileModel.data!.firstName} ${state.profileModel.data!.lastName} (${state.profileModel.data!.occupation})";
                  setState(() {
                    
                  });
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return CircularProgressIndicator();
                }
                if (state is ProfileLoaded) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                image: DecorationImage(
                                    image:
                                        NetworkImage("${ApiClass.mainApi}/${state.profileModel.data!.imageUrl}"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DText(
                                color: Colors.black,
                                text:
                                    "Address: ${state.profileModel.data!.address}",
                                weight: FontWeightManager.medium,
                                size: 14,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              DText(
                                color: Colors.black,
                                text:
                                    "Email: ${state.profileModel.data!.email}",
                                weight: FontWeightManager.medium,
                                size: 14,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              DText(
                                color: Colors.black,
                                text: "Dob: ${state.profileModel.data!.dob}",
                                weight: FontWeightManager.medium,
                                size: 14,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DText(
                          color: Colors.black,
                          text:
                              state.profileModel.data!.bioDescription??"",
                          align: TextAlign.start,
                          weight: FontWeightManager.regular,
                          size: 14,
                        ),
                      ),
                    ],
                  );
                }
                if (state is ProfileError) {
                  return Container(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            ),
            Divider(),
           
          ],
        ),
      ),
    );
  }
}

class FriendsBox extends StatelessWidget {
  String name;
  bool selected;
  void Function() tap;
  FriendsBox(
      {super.key,
      required this.name,
      required this.tap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected == true
              ? ColorManager.primaryColor
              : Color.fromARGB(255, 226, 226, 226),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
          child: DText(
              color: selected == true ? Colors.white : Colors.black,
              text: name,
              weight: FontWeightManager.medium,
              size: 16),
        ),
      ),
    );
  }
}
