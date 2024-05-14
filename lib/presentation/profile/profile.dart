import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:solidarity/bloc/profile/bloc/profile_bloc.dart';
import 'package:solidarity/bloc/profile/category/bloc/category_bloc.dart';
import 'package:solidarity/bloc/profile/friends/bloc/friends_bloc.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/audio_call/audioCall.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/friends_profilke/friends_profile.dart';
import 'package:solidarity/presentation/profile/edit_profile.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:solidarity/resources/extra_widgets.dart';
import 'package:solidarity/resources/fonts.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? currentindex;

  @override
  void initState() {
    
    context.read<FriendsBloc>().add(ByCategoryFriendsGettingEvent());
    context.read<CategoryBloc>().add(CategoryGettingEvent());
    context
        .read<ProfileBloc>()
        .add(ProfileGettingEvent(id: UserSimplePreferences.getId() ?? 1));
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.grey[100], // Change the status bar color
          statusBarIconBrightness:
              Brightness.dark, // Change the status bar icon color
        ),
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
                    SizedBox(
                      height: 5,
                    ),
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
                          return ListShimmer();
                        }
                        if(state is Friendserror){
                          return ListShimmer();
                        }
                        if(state is FriendsLoaded){
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.profileFriendsModel.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.to(()=>FriendProfilePage(id: state.profileFriendsModel.data![index].networkFriend!.id!,
                             
                              ),);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  width: size.width,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                     Row(
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
                                     GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context, builder: (context){
                                            return FeedbackBottomSheet(id: state.profileFriendsModel.data![index].networkFriend!.id!, size: size);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle
                                        ),
                                        child: Icon(Icons.message_outlined,size: 16,)))
                                    ],
                                  ),
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
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return ProfileShimmer(height: 100, width: MediaQuery.of(context).size.width);
                }
                if (state is ProfileLoaded) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                              
                              
                                },
                                child: Container(
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
                              ),
                                      Positioned(
                                                                                      top: 0,
                                                                                      right: 0,
                                                                                      child: GestureDetector(
                                                                                        onTap: (){
                                                                                          Get.to(()=>EditProfilePage(
                                                                                            profileData: state.profileModel.data!,
                                                                                          ));
                                                                                        },
                                                                                        child: Container(
                                                                                                                                            height: 30,
                                                                                                                                            width: 30,
                                                                                                                                            decoration: BoxDecoration(
                                                                                                                                              shape: BoxShape.circle,
                                                                                                                                              color: Colors.white,
                                                                                                                                              border: Border.all(color: ColorManager.primaryColor,width: 2)
                                                                                                                                            ),
                                                                                                                                            child: Center(
                                                                                                                                              child: Icon(Icons.edit,size: 18,),
                                                                                                                                            ),
                                                                                                                                          ),
                                                                                      ))
                            ],
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
                                    "${state.profileModel.data!.firstName} ${state.profileModel.data!.lastName} (${state.profileModel.data!.occupation})",
                                weight: FontWeightManager.semibold,
                                size: 20,
                              ),
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
                                   return ProfileShimmer(height: 100, width: MediaQuery.of(context).size.width);

                }
                return Container();
              },
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  // TODO: implement listener1
                },
                builder: (context, state) {
                  if (state is CategoryLoading) {
                                     return ProfileShimmer(height: 50, width: MediaQuery.of(context).size.width);

                  }
                  if (state is Categoryloaded) {
                    return Container(
                      height: 40,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FriendsBox(
                              name: "All",
                              selected: currentindex == null ? true : false,
                              tap: () {
                                currentindex = null;
                                context.read<FriendsBloc>().add(ByCategoryFriendsGettingEvent());
                                setState(() {});
                              },
                            ),
                           state.categoryModel.data==[]?
                           DText(color: Colors.black, text: "No Friends Found",
                            weight: FontWeightManager.semibold, size: 16):
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.categoryModel.data!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return FriendsBox(
                                    selected:
                                        currentindex == index ? true : false,
                                    tap: () {
                                      currentindex = index;
                                      setState(() {
                                        context.read<FriendsBloc>().add(ByCategoryFriendsGettingEvent(id: 
                                        state.categoryModel.data![index].id
                                        ));
                                      });
                                    },
                                    name:
                                        "${state.categoryModel.data![index].title}",
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is CategoryError) {
                                     return ProfileShimmer(height: 50, width: MediaQuery.of(context).size.width);

                  }
                  return Container();
                },
              ),
            ),
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
