import 'package:app_ranking_mounstros/pages/principal_page.dart';
import 'package:app_ranking_mounstros/services/cloud_firestore_service.dart';
import 'package:app_ranking_mounstros/services/firebase_messaging_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CloudFirestoreService()),
        Provider(create: (_) => FirebaseMessagingService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: PrincipalPage()
      ),
    );
  }
}