import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService{
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messageStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _messageStreamController.stream;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (info){
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['nombre'] ?? 'no-data';
        }
        _messageStreamController.sink.add(argumento);
        print(info);
      },
      onLaunch: (info){
        print("Firebase onLaunch");
        print(info);
      },
      onResume: (info){
        print("Firebase onResume");
      }
    );
  }

  Future<void> getToken() async{
    final String token= await _firebaseMessaging.getToken();
    print(token);
  }

}