import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solidarity/bloc/chat/bloc/chat_history_bloc.dart';
import 'package:solidarity/bloc/chat/sendChat/bloc/send_chat_bloc.dart';
import 'package:solidarity/data/controller/auth_controller.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/presentation/audio_call/audioCall.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/extra_widgets.dart';
import 'package:solidarity/resources/fonts.dart';

class ChatPage extends StatefulWidget {
  int id;
  String name;
   ChatPage({super.key,required this.id,required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final String localUserId = math.Random().nextInt(10000).toString();
  String? userId;
  List<String> cards = [
    "assets/images/gifts/birthday1.jpg",
    "assets/images/gifts/birthday3.jpg",
    "assets/images/gifts/birthday5.png",
    "assets/images/gifts/wedding1.jpg"
  ];

  int selectedIndex = 0;
  List<ChatModelPage> chatList = [];
  TextEditingController textEditingController = TextEditingController();
    ScrollController scrollController = ScrollController();
  void _scrollDown() {
    Future.delayed(Duration(milliseconds: 200), () {
     if(scrollController.hasClients){
       scrollController.jumpTo(
      scrollController.position.maxScrollExtent,
    );
             setState(() {});
     }
    });
  }


@override
  void initState() {
       context
                                .read<ChatHistoryBloc>()
                                .add(ChatGettingEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("thi is ${widget.id}");
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: (){
                DialogBox().dialogbox(context);
                                AuthController().getCall(widget.id).then((value) {
                                  if(value == true){
                                    Get.back();
                                   Get.to(AudioCallPage(localUserId: localUserId,fId: UserSimplePreferences.getId()!=null?widget.id.toString():"444",));
                                  }
                                  else{
                                    Get.back();
                                  }
                                });
                                setState(() {
                                  
                                });
              },
              child: Icon(Icons.call,color: Colors.white,)),
          )
        ],
        forceMaterialTransparency: false,
        centerTitle: true,
        backgroundColor: ColorManager.primaryColor,
        title: DText(
            color: Colors.white,
            text: widget.name,
            weight: FontWeightManager.semibold,
            size: 18),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              BlocConsumer<ChatHistoryBloc, ChatHistoryState>(
                listener: (context, state) {
                  if (state is ChatHistoryLoaded) {
                    for(int i=0;i<state.chatModel.data!.length;i++){
                      chatList.add(ChatModelPage(date: state.chatModel.data![i].createdAt??"",
                       from: state.chatModel.data![i].sendFrom??"", text: state.chatModel.data![i].message??"", to: state.chatModel.data![i].sendTo??""));
                    }
                    setState(() {
                         if(chatList.isNotEmpty){
                           if(chatList.length > 5){
                            _scrollDown();
                           }
                         }

                    });
                  }
                },
                builder: (context, state) {
                  if (state is ChatHistoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ChatHistoryLoaded) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        itemCount: chatList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return chatList[index].from ==
                                  UserSimplePreferences.getId().toString()
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Center(
                                          child: DText(
                                        text:
                                            "Sent on ${DateFormat("MMM,dd").format(DateTime.parse(chatList[index].date.toString()))}",
                                        weight: FontWeightManager.regular,
                                        size: 12,
                                        color: Colors.grey[700]!,
                                      )),
                                      SizedBox(height: 10.0),
                                     chatList[index].text.endsWith("png")||chatList[index].text.endsWith("jpg")?
                                     Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color:  Colors.grey[500]!,width: 2),
                    image: DecorationImage(image: AssetImage(chatList[index].text),fit: BoxFit.cover)
                  ),
                ):
                                      IntrinsicWidth(
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerRight,
                                          widthFactor: 0.75,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(240, 242, 246, 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: DText(
                                                text: chatList[index]
                                                        .text,
                                                size: 14,
                                                weight: FontWeightManager.regular,
                                                color: ColorManager.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                     index == chatList.length? Container(
                                        height: 10,
                                        width: 50,
                                        child: BlocConsumer<SendChatBloc, SendChatState>(
                                          listener: (context, state) {
                                            if(state is SendChatLoading){
                                              print("loading");
                                            }
                                            if(state is SendChatloaded){
                                            }
                                            if(state is SendChatError){
                                              print("e");
                                            }
                                          },
                                          builder: (context, state) {
                                            if(state is SendChatLoading){
                                              return
                                             DText(
                                                color: Colors.grey,
                                                text: "Sending...",
                                                weight: FontWeightManager.regular,
                                                size: 12);
                                            }
                                            if(state is SendChatloaded){
                                              return Container();
                                            }
                                            if(state is SendChatError){
                                              DText(
                                                color: Colors.grey,
                                                text: "Failed !",
                                                weight: FontWeightManager.regular,
                                                size: 12);
                                            }
                                            return Container();
                                          },
                                        ),
                                      ):Container()
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: DText(
                                        text:
                                            "Received on ${DateFormat("MMM,dd").format(DateTime.parse(chatList[index].date.toString()))}",
                                        weight: FontWeightManager.regular,
                                        size: 12,
                                        color: Colors.grey[700]!,
                                      )),
                                      SizedBox(height: 10.0),
                                   chatList[index].text.endsWith("png")||chatList[index].text.endsWith("jpg")? Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color:  Colors.grey[500]!,width: 2),
                    image: DecorationImage(image: AssetImage(chatList[index].text),fit: BoxFit.cover)
                  ),
                ):  IntrinsicWidth(
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerRight,
                                          widthFactor: 0.75,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromRGBO(240, 242, 246, 1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: DText(
                                                text: chatList[index]
                                                        .text ??
                                                    "",
                                                size: 14,
                                                weight: FontWeightManager.regular,
                                                color: ColorManager.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        });
                  }
                  if (state is ChatHistoryError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Center(
                    child: Text("Error Occured"),
                  );
                },
              ),
              SizedBox(height: 90,)
            ],
          ),
        ),
      ),

      //bottomsheet
      bottomSheet: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
        width: size.width,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey[300]!, offset: Offset(3, 1))
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context, builder: (context)
                {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                            padding: EdgeInsets.all(10),
                            height: size.height*0.28,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 130,
                                  width: size.width,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cards.length,
                                    itemBuilder: (context,ind){
                                      return GestureDetector(
                                        onTap: (){
                                          selectedIndex = ind;
                                          setState(() {
                                            
                                          });
                                        },
                                        child: Container(
                                                              margin: EdgeInsets.only(right: 15),
                                                              height: 100,
                                                              width: 100,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(color: selectedIndex==ind?ColorManager.primaryColor: Colors.grey[500]!,width: 2),
                                                                image: DecorationImage(image: AssetImage(cards[ind]))
                                                              ),
                                        ),
                                      );
                                  }),
                                  
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    chatList.add(ChatModelPage(date: DateTime.now().toIso8601String(),
                                       from: UserSimplePreferences.getId().toString(), text: cards[selectedIndex], to: 
                                      widget.id.toString()));
                                                                                    // _scrollDown();
                                      context.read<SendChatBloc>().add(SendingMessageEvent(
                                          message: cards[selectedIndex], id: widget.id));
                                          Get.back();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: ColorManager.primaryColor,
                                      border: Border.all(color: Colors.grey,width: 2)
                                    ),
                                    child: Center(
                                      child: DText(color: Colors.white, text: "Send Card", weight: FontWeightManager.semibold, size: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                    }
                  );
                }).then((value) {
                  setState(() {
                    _scrollDown();
                  });
                });
              },
              child: Container(
                height: 43,
                width: size.width*0.10,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey
                  ),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Center(
                  child: Icon(Icons.card_giftcard),
                ),
              ),
            ),
            Container(
                width: size.width * 0.60,
                child: TextField(
                  onTap: () {
                    _scrollDown();
                  },
                  controller: textEditingController,
                  maxLines: 3,
                  minLines: 1,
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      hintText: "Type here ..",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 5),
                          borderRadius: BorderRadius.circular(10))),
                )),
            GestureDetector(
              onTap: () {
                chatList.add(ChatModelPage(date: DateTime.now().toIso8601String(),
                 from: UserSimplePreferences.getId().toString(), text: textEditingController.text, to: 
                widget.id.toString()));
                                                              _scrollDown();
                context.read<SendChatBloc>().add(SendingMessageEvent(
                    message: textEditingController.text, id: widget.id));
                    setState(() {
                      textEditingController.clear();
      FocusScope.of(context).unfocus();
                    });
              },
              child: Container(
                height: 45,
                width: size.width * 0.15,
                decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class ChatModelPage {
  String text;
  String from;
  String to;
  String date;
  ChatModelPage({required this.date,required this.from,required this.text,required this.to});
}


