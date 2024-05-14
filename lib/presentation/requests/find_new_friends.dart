import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:solidarity/bloc/new_friends/friend_list/bloc/new_friend_list_bloc.dart';
import 'package:solidarity/bloc/new_friends/send_accept/bloc/send_accept_bloc.dart';
import 'package:solidarity/data/model/new_friends/new_friends_model.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/friends_profilke/friends_profile.dart';
import 'package:solidarity/presentation/requests/accept_request.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:solidarity/resources/fonts.dart';

class FindNewFriendsPage extends StatefulWidget {
  const FindNewFriendsPage({super.key});

  @override
  State<FindNewFriendsPage> createState() => _FindNewFriendsPageState();
}

class _FindNewFriendsPageState extends State<FindNewFriendsPage> {
  TextEditingController textEditingController = TextEditingController();
  List<int> indexList = [];
  List<NewData> searchedFriends=[];
_onSearchTextChanged(String text)async{
        var videoss = context.read<NewFriendListBloc>().newFriendsController.friends;

      searchedFriends.clear();

      if(textEditingController.text.isEmpty){
        setState(() {
        });
        return;
      }
      for (var searchDetails in videoss) {
        if(searchDetails.firstName!.toLowerCase().contains(textEditingController.text.toLowerCase()) || searchDetails.lastName!.toLowerCase().contains(textEditingController.text.toLowerCase())){
          searchedFriends.add(searchDetails);
        }
       }
       
       setState(() {
         
       });
    }
  @override
  void initState() {
    context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, builder: (context){
                  return Container(
                    padding: EdgeInsets.all(16),
                    height: size.height*0.1,
                    width: size.width,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>AcceptRequestPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Center(
                          child: DText(color: Colors.black,
                           text: "View Friend Requests", weight: FontWeightManager.medium,
                            size: 16),
                        ),
                      ),
                    ),
                  );
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.menu,color: Colors.white,),
            ),
          )
        ],
        forceMaterialTransparency: false,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(
            color: Colors.white,
            text: "Find New Friends",
            weight: FontWeightManager.semibold,
            size: 18),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchPoint(size),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<NewFriendListBloc, NewFriendListState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is NewFriendListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is NewFriendListError) {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                  if (state is NewFriendListLoaded) {
                    return searchedFriends.isEmpty && textEditingController.text.isNotEmpty?
                  Center(child: DText(color: Colors.black, text: "No Friends Found", weight: FontWeightManager.medium, size: 16),):
                  searchedFriends.isEmpty? _friendsList(state, size):
                     ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchedFriends.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return searchedFriends[index].isFriend == true?Container(): GestureDetector(
                            onTap: (){
                              Get.to(()=>FriendProfilePage(id: searchedFriends[index].id!,
                             
                              ),);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: size.width,
                              decoration: BoxDecoration(color: Colors.grey[200]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 3, color: Colors.white),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${ApiClass.mainApi}/${searchedFriends[index].imageUrl}"),
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
                                              text:
                                                  "${searchedFriends[index].firstName} ${searchedFriends[index].lastName}",
                                              weight: FontWeightManager.medium,
                                              size: 16),
                                          DText(
                                              color: Colors.black,
                                              text: state.newFriendsModel
                                                      .data![index].phone ??
                                                  "",
                                              weight: FontWeightManager.regular,
                                              size: 14),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (searchedFriends[index]
                                              .friendRequestSent ==
                                          false) {
                                        context.read<SendAcceptBloc>().add(
                                            SendingRequestEvent(
                                                sendFrom:
                                                    UserSimplePreferences.getId()
                                                        .toString(),
                                                sendTo: state.newFriendsModel
                                                    .data![index].id
                                                    .toString()));
                                      } else if(searchedFriends[index]
                                              .friendRequestSent ==
                                          true) {
                                          
                                      }
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      ColorManager.primaryColor,
                                                  width: 2)),
                                          child: Center(
                                              child: BlocConsumer<SendAcceptBloc,
                                                  SendAcceptState>(
                                            listener: (context, stat) {
                                              if(stat is SendAcceptLoaded){
                                              context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());
                                                
                                              }
                                              if(stat is SendAcceptError){
                                              print(stat.message);
                                              }
                                              if(stat is SendCancelLoaded){
                                                   context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());
                            
                                              }
                                            },
                                            builder: (context, stat) {
                                              return Icon(
                                                searchedFriends[index]
                                                            .friendRequestSent !=
                                                        true 
                                                    ? Icons.check
                                                    : Icons.person_3_outlined,
                                                size: 16,
                                              );
                                            },
                                          )),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        DText(
                                            color: Colors.blue,
                                            text:searchedFriends[index]
                                                            .friendRequestSent !=
                                                        false 
                                                    ?"Request Sent": "Send Request",
                                            weight: FontWeightManager.regular,
                                            size: 12)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: Text("Something went wrong"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView _friendsList(NewFriendListLoaded state, Size size) {
    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.newFriendsModel.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return state.newFriendsModel.data![index].isFriend == true?Container(): GestureDetector(
                          onTap: (){
                            Get.to(()=>FriendProfilePage(id: state.newFriendsModel.data![index].id!,
                           
                            ),);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            width: size.width,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${ApiClass.mainApi}/${state.newFriendsModel.data![index].imageUrl}"),
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
                                            text:
                                                "${state.newFriendsModel.data![index].firstName} ${state.newFriendsModel.data![index].lastName}",
                                            weight: FontWeightManager.medium,
                                            size: 16),
                                        DText(
                                            color: Colors.black,
                                            text: state.newFriendsModel
                                                    .data![index].email ??
                                                "",
                                            weight: FontWeightManager.regular,
                                            size: 14),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (state.newFriendsModel.data![index]
                                            .friendRequestSent ==
                                        false) {
                                      context.read<SendAcceptBloc>().add(
                                          SendingRequestEvent(
                                              sendFrom:
                                                  UserSimplePreferences.getId()
                                                      .toString(),
                                              sendTo: state.newFriendsModel
                                                  .data![index].id
                                                  .toString()));
                                    } else if(state.newFriendsModel.data![index]
                                            .friendRequestSent ==
                                        true) {
                                        
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color:
                                                    ColorManager.primaryColor,
                                                width: 2)),
                                        child: Center(
                                            child: BlocConsumer<SendAcceptBloc,
                                                SendAcceptState>(
                                          listener: (context, stat) {
                                            if(stat is SendAcceptLoaded){
                                            context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());
                                              
                                            }
                                            if(stat is SendAcceptError){
                                            print(stat.message);
                                            }
                                            if(stat is SendCancelLoaded){
                                                 context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());
                          
                                            }
                                          },
                                          builder: (context, stat) {
                                            return Icon(
                                              state.newFriendsModel.data![index]
                                                          .friendRequestSent !=
                                                      false 
                                                  ? Icons.check
                                                  : Icons.person_3_outlined,
                                              size: 16,
                                            );
                                          },
                                        )),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      DText(
                                          color: Colors.blue,
                                          text:state.newFriendsModel.data![index]
                                                          .friendRequestSent !=
                                                      false 
                                                  ?"Request Sent": "Send Request",
                                          weight: FontWeightManager.regular,
                                          size: 12)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
  }

  //search bar
  Container _searchPoint(Size size) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      width: size.width,
      decoration: BoxDecoration(color: ColorManager.primaryColor),
      child: TextField(
        controller: textEditingController,
        onChanged: (val) {
          _onSearchTextChanged(textEditingController.text.trim());
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            hintText: "Search..",
            filled: true,
            fillColor: Colors.white,
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}
