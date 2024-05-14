import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solidarity/bloc/auth/bloc/auth_bloc.dart';
import 'package:solidarity/bloc/chat/bloc/chat_history_bloc.dart';
import 'package:solidarity/bloc/chat/chat_friends/bloc/chat_friends_bloc.dart';
import 'package:solidarity/bloc/chat/sendChat/bloc/send_chat_bloc.dart';
import 'package:solidarity/bloc/new_friends/bloc/accept_request_bloc.dart';
import 'package:solidarity/bloc/new_friends/friend_list/bloc/new_friend_list_bloc.dart';
import 'package:solidarity/bloc/new_friends/friend_request/bloc/friend_requests_bloc.dart';
import 'package:solidarity/bloc/new_friends/send_accept/bloc/send_accept_bloc.dart';
import 'package:solidarity/bloc/profile/bloc/profile_bloc.dart';
import 'package:solidarity/bloc/profile/category/bloc/category_bloc.dart';
import 'package:solidarity/bloc/profile/friends/bloc/friends_bloc.dart';
import 'package:solidarity/firebase_options.dart';
import 'package:solidarity/local_database/usersimplepreferences.dart';
import 'package:solidarity/notification/local_notification.dart';
import 'package:solidarity/presentation/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Permission.notification.request();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
  );
    LocalNotificationService.initialize();

  await UserSimplePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(create: (context){
        return AuthBloc();
      }),
      BlocProvider<CategoryBloc>(create: (context){
        return CategoryBloc();
      }),
       BlocProvider<ProfileBloc>(create: (context){
        return ProfileBloc();
      }),
      BlocProvider<ChatHistoryBloc>(create: (context){
        return ChatHistoryBloc();
      }),
      BlocProvider<SendChatBloc>(create: (context){
        return SendChatBloc();
      }),
      BlocProvider<ChatFriendsBloc>(create: (context){
        return ChatFriendsBloc();
      }),
      BlocProvider<FriendsBloc>(create: (context){
        return FriendsBloc();
      }),
       BlocProvider<NewFriendListBloc>(create: (context){
        return NewFriendListBloc();
      }),
        BlocProvider<SendAcceptBloc>(create: (context){
        return SendAcceptBloc();
      }),
      BlocProvider<FriendRequestsBloc>(create: (context){
        return FriendRequestsBloc();
      }),
      BlocProvider<AcceptRequestBloc>(create: (context){
        return AcceptRequestBloc();
      })
    ], child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Solidarity",
      home: SplashView(),
    ));
  }
}