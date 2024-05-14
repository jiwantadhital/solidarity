import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:solidarity/bloc/new_friends/bloc/accept_request_bloc.dart';
import 'package:solidarity/bloc/new_friends/friend_list/bloc/new_friend_list_bloc.dart';
import 'package:solidarity/bloc/new_friends/friend_request/bloc/friend_requests_bloc.dart';
import 'package:solidarity/bloc/profile/category/bloc/category_bloc.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:solidarity/resources/fonts.dart';

class AcceptRequestPage extends StatefulWidget {
  const AcceptRequestPage({super.key});

  @override
  State<AcceptRequestPage> createState() => _AcceptRequestPageState();
}

class _AcceptRequestPageState extends State<AcceptRequestPage> {
  TextEditingController textEditingController = TextEditingController();
  List<int> indexList = [];

  @override
  void initState() {
    context.read<FriendRequestsBloc>().add(FriendRequestGettingEvent());
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
            text: "Friend Requests",
            weight: FontWeightManager.semibold,
            size: 18),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // _searchPoint(size),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<FriendRequestsBloc, FriendRequestsState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is FriendRequestsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FriendRequestsError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  if (state is FriendRequestsLoaded) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.friendRequestsModel.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.to(()=>FriendProfilePage(id: state.friendRequestsModel.data![index].id!,
                              // sentRequest: state.friendRequestsModel.data![index].friendRequestSent
                              // =="no"?false:true,
                              // ),);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: size.width,
                              decoration:
                                  BoxDecoration(color: Colors.grey[200]),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                    "${ApiClass.mainApi}/${state.friendRequestsModel.data![index].requestSendFrom!.imageUrl}"),
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
                                                  "${state.friendRequestsModel.data![index].requestSendFrom!.firstName} ${state.friendRequestsModel.data![index].requestSendFrom!.lastName}",
                                              weight: FontWeightManager.medium,
                                              size: 16),
                                          DText(
                                              color: Colors.black,
                                              text: state
                                                      .friendRequestsModel
                                                      .data![index]
                                                      .requestSendFrom!
                                                      .phone ??
                                                  "",
                                              weight: FontWeightManager.regular,
                                              size: 14),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  padding: EdgeInsets.all(16),
                                                  width: size.width,
                                                  height: size.height * 0.5,
                                                  color: Colors.white,
                                                  child: BlocConsumer<
                                                      CategoryBloc,
                                                      CategoryState>(
                                                    listener:
                                                        (context, sta) {
                                                      // TODO: implement listener
                                                    },
                                                    builder:
                                                        (context, sta) {
                                                      return sta is Categoryloaded? Column(
                                                        children: [
                                                          DText(color: Colors.black,
                                                           text: "Accept As",
                                                            weight: FontWeightManager.bold, size: 16),
                                                            SizedBox(height: 10,),
                                                          ListView.builder(
                                                              shrinkWrap:
                                                                  true,
                                                              itemCount: sta.categoryModel.data!.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      inde) {
                                                                return GestureDetector(
                                                                  onTap: (){
                                                                    context.read<AcceptRequestBloc>().add(
                                                                      AcceptingRequestEvent(
                                                                        networkId: 
                                                                        sta.categoryModel.data![inde].id!.toString(),
                                                                         requestId: state.friendRequestsModel.data![index].id.toString())
                                                                    );
                                                                    Get.back();
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.all(10),
                                                                    margin: EdgeInsets.only(
                                                                        top:
                                                                            10,
                                                                        bottom:
                                                                            10),
                                                                   decoration: BoxDecoration(
                                                                    color: Colors.grey[300],
                                                                    borderRadius: BorderRadius.circular(8)
                                                                   ),
                                                                    width: size
                                                                        .width,
                                                                   child: Center(
                                                                     child: DText(color: Colors.black,
                                                                      text: sta.categoryModel.data![inde].title??"", weight: FontWeightManager.medium,
                                                                       size: 14),
                                                                   ),
                                                                  ),
                                                                );
                                                              }),
                                                        ],
                                                      ):Container();
                                                    },
                                                  ),
                                                );
                                              });
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
                                                      color: ColorManager
                                                          .primaryColor,
                                                      width: 2)),
                                              child: Center(
                                                  child: BlocConsumer<
                                                      AcceptRequestBloc,
                                                      AcceptRequestState>(
                                                listener: (context, stat) {
                                                  if (stat
                                                      is AcceptRequestLoaded) {
                                                    context
                                                        .read<
                                                            FriendRequestsBloc>()
                                                        .add(
                                                            FriendRequestGettingEvent());
                                                  }
                                                  if (stat
                                                      is AcceptRequestError) {
                                                    print(stat.message);
                                                  }
                                                  if(stat is CancelRequestLoaded){
 context
                                                        .read<
                                                            FriendRequestsBloc>()
                                                        .add(
                                                            FriendRequestGettingEvent());
                                                  }
                                                },
                                                builder: (context, stat) {
                                                  return Icon(
                                                    Icons.person_3_outlined,
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
                                                text: "Accept",
                                                weight:
                                                    FontWeightManager.regular,
                                                size: 12)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context.read<AcceptRequestBloc>().add(CancelingRequest(id: state.friendRequestsModel.data![index].id!));
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
                                                      color: ColorManager
                                                          .primaryColor,
                                                      width: 2)),
                                              child: Center(
                                                  child: BlocConsumer<
                                                      AcceptRequestBloc,
                                                      AcceptRequestState>(
                                                listener: (context, stat) {
                                                  if (stat
                                                      is AcceptRequestLoaded) {
                                                    context
                                                        .read<
                                                            NewFriendListBloc>()
                                                        .add(
                                                            NewFriendsListGettingEvent());
                                                  }
                                                  if (stat
                                                      is AcceptRequestError) {
                                                    print(stat.message);
                                                  }
                                                  // if(stat is SendCancelLoaded){
                                                  //      context.read<NewFriendListBloc>().add(NewFriendsListGettingEvent());

                                                  // }
                                                },
                                                builder: (context, stat) {
                                                  return Icon(
                                                    Icons.remove,
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
                                                text: "Reject",
                                                weight:
                                                    FontWeightManager.regular,
                                                size: 12)
                                          ],
                                        ),
                                      ),
                                    ],
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

  //search bar
  Container _searchPoint(Size size) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      width: size.width,
      decoration: BoxDecoration(color: ColorManager.primaryColor),
      child: TextField(
        controller: textEditingController,
        onChanged: (val) {},
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
