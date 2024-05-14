import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solidarity/bloc/chat/sendChat/bloc/send_chat_bloc.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/resources/colors.dart';
import 'package:solidarity/resources/fonts.dart';

class DialogBox{

dialogbox(context){
  return showDialog(
                                    barrierDismissible: false,
                                    context: context, builder: (context){
                               return Center(
                                 child: Container(
                                  padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: 60,
                                decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                        ),
                                  child: CircularProgressIndicator(color: ColorManager.primaryColor,strokeWidth: 5,),
                                ),
                              );
                                        });
}

//download
downloadbox(context){
  return showDialog(
                                    barrierDismissible: false,
                                    context: context, builder: (context){
                               return Center(
                                 child: Container(
                                  padding: const EdgeInsets.all(10),
                                      height: 60,
                                      width: 60,
                                decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white
                                        ),
                                  child: CircularProgressIndicator(color: ColorManager.primaryColor,strokeWidth: 5,),
                                ),
                              );
                                        });
}

}

class ShowSnackBar{
  snack(String text, Color color){
    final snackBar = SnackBar(
      backgroundColor: color,
  content: Text(text),
);

  return snackBar;


  }
}


//listview shimmer


class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context,index){
        return Container(
          child: BoxShimmer(
            frontBoxSize: 30.0,
            smallBoxSize: 5.0,
            bigBoxSize: 10.0,
            color: Colors.transparent,
          )
        );
      }),
    );
  }
}


class ProfileShimmer extends StatelessWidget {
  double height;
  double width;
   ProfileShimmer({super.key,required this.height,required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 216, 214, 214),
            highlightColor: Colors.grey[200]!,
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          );
  }
}

class BoxShimmer extends StatelessWidget {
  double frontBoxSize;
  double smallBoxSize;
  double bigBoxSize;
  Color color;

   BoxShimmer({
    super.key,
    this.frontBoxSize = 60.0,
    this.smallBoxSize = 15.0,
    this.bigBoxSize = 35.0,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // height: responsiveHeight(80.0, context),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
                    color: color,
      borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 216, 214, 214),
            highlightColor: Colors.grey[200]!,
            child: Container(
              height: frontBoxSize,
              width: frontBoxSize,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 216, 214, 214),
                highlightColor: Colors.grey[200]!,child: Container(
                 decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  height: smallBoxSize,width: MediaQuery.of(context).size.width*0.6,)),
                  SizedBox(height: 10,),
                  Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 216, 214, 214),
                highlightColor: Colors.grey[200]!,child: Container(
                 decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  height: bigBoxSize,width: MediaQuery.of(context).size.width*0.6,)),
            ],
          )
        ],
      ),
    );
  }
}


//feedback bottomsheet
class FeedbackBottomSheet extends StatefulWidget {
  int id;
  FeedbackBottomSheet({
    super.key,
    required this.id,
    required this.size,
  });

  final Size size;

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.all(16),
          width: widget.size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 4,
                  width: 64,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DText(
                text: "Send Message",
                size: 16,
                color: Colors.black,
                weight: FontWeightManager.medium,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: textEditingController,
                onChanged: (val) {},
                maxLines: 7,
                maxLength: 250,
                decoration: InputDecoration(
                    hintText: "Type here..", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<SendChatBloc, SendChatState>(
                listener: (context, state) {
                  if(state is SendChatloaded){
                    // context.read<SuggestionsBloc>().add(SuggestiongettingEvent());
                    Get.back();
                  }
                  if(state is SendChatError){
                    Get.back();
                  }
                },
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        if(textEditingController.text.isEmpty){

                        }
                        else{
                          context.read<SendChatBloc>().add(SendingMessageEvent(
                    message: textEditingController.text, id: widget.id));
                    setState(() {
                      textEditingController.clear();
                  FocusScope.of(context).unfocus();
                    });
                        }
                      },
                      child: Container(
                        height: 50,
                        width: widget.size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 12, 94, 161),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: GestureDetector(
                                child: DText(
                          text:state is SendChatLoading?"Submitting...": "Submit",
                          color: Colors.white,
                          size: 14,
                          weight: FontWeightManager.medium,
                        ))),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}