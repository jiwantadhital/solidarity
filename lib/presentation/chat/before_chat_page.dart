import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:solidarity/bloc/chat/bloc/chat_history_bloc.dart';
import 'package:solidarity/bloc/chat/chat_friends/bloc/chat_friends_bloc.dart';
import 'package:solidarity/data/model/chat/chat_friends_model.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/presentation/chat/chat_page.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/constants.dart';
import 'package:solidarity/resources/fonts.dart';

class BeforeChatPage extends StatefulWidget {
  const BeforeChatPage({super.key});

  @override
  State<BeforeChatPage> createState() => _BeforeChatPageState();
}

class _BeforeChatPageState extends State<BeforeChatPage> {
  TextEditingController textEditingController = TextEditingController();
List<Dataum> searchedFriends = [];
@override
  void initState() {
    context.read<ChatFriendsBloc>().add(ChatFriendGettingEvent());
    super.initState();
  }
_onSearchTextChanged(String text)async{
        var videoss = context.read<ChatFriendsBloc>().chatController.friends;

      searchedFriends.clear();

      if(textEditingController.text.isEmpty){
        setState(() {
        });
        return;
      }
      for (var searchDetails in videoss) {
        if(searchDetails.sendFrom!.name!.toLowerCase().contains(textEditingController.text.toLowerCase()) ){
          searchedFriends.add(searchDetails);
        }
       }
       
       setState(() {
         
       });
    }


    Future<void> _onRefresh()async{
    context.read<ChatFriendsBloc>().add(ChatFriendGettingEvent());
    }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        forceMaterialTransparency: false,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(
            color: Colors.white,
            text: "Chats",
            weight: FontWeightManager.semibold,
            size: 18),
      ),
      body: Container(
        child: Column(
          children: [
            _searchPoint(size),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<ChatFriendsBloc, ChatFriendsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is ChatFriendsLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(state is ChatFriendsError){
                  return Center(
                    child: DText(color: Colors.black, text: state.message,
                     weight: FontWeightManager.semibold, size: 16),
                  );
                }
                if(state is ChatFriendsLoaded){
                  return Expanded(
                  child: searchedFriends.isEmpty && textEditingController.text.isNotEmpty?
                  Center(child: DText(color: Colors.black, text: "No Friends Found", weight: FontWeightManager.medium, size: 16),):
                  searchedFriends.isEmpty?
                  RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.chatFriendModel.data!.length,
                        itemBuilder: (context, index) {
                          String image = state.chatFriendModel.data![index].sendFrom!.id == state.chatFriendModel.data![index].chatWith? state.chatFriendModel.data![index].sendFrom!.imageUrl!:state.chatFriendModel.data![index].sendTo!.imageUrl!;
                          String name = state.chatFriendModel.data![index].sendFrom!.id == state.chatFriendModel.data![index].chatWith? state.chatFriendModel.data![index].sendFrom!.name!:state.chatFriendModel.data![index].sendTo!.name!;
                    
                          return GestureDetector(
                            onTap: () {                         
                              Get.to(ChatPage(id: int.parse(state.chatFriendModel.data![index].chatWith!),
                              name: "${name}",
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: size.width,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 3,
                                            color: ColorManager.primaryColor),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${ApiClass.mainApi}/${image}"),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: size.width * 0.7,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        DText(
                                            color: Colors.black,
                                            text: "${name}",
                                            weight: FontWeightManager.medium,
                                            size: 16),
                                        state.chatFriendModel.data![index].message!.endsWith("png")||state.chatFriendModel.data![index].message!.endsWith("jpg")?
                                       Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color:  Colors.grey[500]!,width: 2),
                      image: DecorationImage(image: AssetImage(state.chatFriendModel.data![index].message!),fit: BoxFit.cover)
                    ),
                                    ):
                                        DText(
                                            color: Colors.black,
                                            text:
                                                state.chatFriendModel.data![index].message??"",
                                            weight: FontWeightManager.regular,
                                            size: 13)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ):ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchedFriends.length,
                      itemBuilder: (context, index) {
                             String image = state.chatFriendModel.data![index].sendFrom!.id == state.chatFriendModel.data![index].chatWith? state.chatFriendModel.data![index].sendFrom!.imageUrl!:state.chatFriendModel.data![index].sendTo!.imageUrl!;
                        String name = state.chatFriendModel.data![index].sendFrom!.id == state.chatFriendModel.data![index].chatWith? state.chatFriendModel.data![index].sendFrom!.name!:state.chatFriendModel.data![index].sendTo!.name!;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<ChatHistoryBloc>()
                                .add(ChatGettingEvent(id: int.parse(state.chatFriendModel.data![index].chatWith!)));
                            Get.to(ChatPage(id: int.parse(searchedFriends[index].chatWith!),name: "${name}"));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: size.width,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: ColorManager.primaryColor),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${ApiClass.mainApi}/${image}"),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: size.width * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DText(
                                          color: Colors.black,
                                          text: "${name}",
                                          weight: FontWeightManager.medium,
                                          size: 16),
                                      DText(
                                          color: Colors.black,
                                          text:
                                              searchedFriends[index].message??"",
                                          weight: FontWeightManager.regular,
                                          size: 13)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
                }
                return Center(
                 child: DText(color: Colors.black, text: "Something went wrong",
                     weight: FontWeightManager.semibold, size: 16),
                );
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () {},
      //     label: Row(
      //       children: [
      //         Icon(Icons.add),
      //         SizedBox(
      //           width: 5,
      //         ),
      //         DText(
      //             color: Colors.black,
      //             text: "New Chat",
      //             weight: FontWeightManager.semibold,
      //             size: 16)
      //       ],
      //     )),
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
        onChanged: (val){
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
