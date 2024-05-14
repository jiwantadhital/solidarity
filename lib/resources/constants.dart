import 'package:flutter/material.dart';

class ApiClass{
  //localhost
    // static const mainApi = "http://10.0.2.2:8000/";
    // static const local = "http://10.0.2.2:8000/" ;
    static const mainApi = "https://its-rahul.com";
    static const local = "https://forstudents678.xyz/public/" ;
    static const appId = 903559779;
    static const appSignIn = "0363d1c92194d1e6146fe200886de32ff4f8e046f8de6e8a2cbbf0cfde0bdad8";

    static const login = "/api/customer/login" ;
    static const register = "/api/customer/register" ;
    static const editProfile = "/api/customer/update-user" ;



    static const profile = "/api/customer/details" ;
    static const networkCategory = "/api/customer/network-categories" ;
    static const friends = "/api/customer/network-categories" ;
    static const chatFriend = "/api/customer/chat-list" ;

    static const profileFriends = "/api/customer/my-network" ;

    static const newFriends = "/api/customer/find-new-friends" ;
    static const sendRequest = "/api/customer/sent-request" ;
    static const cancelRequest = "/api/customer/cancel-request" ;
    static const friendRequestList = "/api/customer/friend-requests" ;
    static const acceptRequest = "/api/customer/accept-request" ;
    static const callApi = "/api/customer/send-notification-fcm" ;





    static const chat = "/api/customer/chat-history" ;
    static const sendChat = "/api/customer/send-message" ;





   

}