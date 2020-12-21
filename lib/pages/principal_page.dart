import 'package:app_ranking_mounstros/helpers/helpers.dart';
import 'package:app_ranking_mounstros/services/cloud_firestore_service.dart';
import 'package:app_ranking_mounstros/services/firebase_messaging_service.dart';
import 'package:app_ranking_mounstros/widgets/crear_mounstro.dart';
import 'package:app_ranking_mounstros/widgets/monster_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrincipalPage extends StatefulWidget {

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  CloudFirestoreService firestoreService;
  FirebaseMessagingService messagingService;

  final GlobalKey<State> principalKey = new GlobalKey<State>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      messagingService.getToken();
      messagingService.initNotifications();
      messagingService.mensajes.listen((event) {
        mostrarAlert(principalKey.currentContext, "$event ahora ocupa el primer puesto" ,"",(){});
      });  
    });
  }
  @override
  Widget build(BuildContext context) {
    
    firestoreService = Provider.of<CloudFirestoreService>(context);
    messagingService = Provider.of<FirebaseMessagingService>(context);
    return Scaffold(
      key: principalKey,
      appBar: AppBar(
        title: Text("Ranking de mounstros"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firestoreService.streamMonstersData(),
        builder: (BuildContext context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
            case ConnectionState.none: return Center(child: CircularProgressIndicator());
            case ConnectionState.active: return MonsterDetail(firestoreService.mostrarMounstrous(snapshot.data.documents));
            case ConnectionState.done: return MonsterDetail(firestoreService.mostrarMounstrous(snapshot.data.documents));
          }
          return CircularProgressIndicator();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: CrearMounstro(),
            )
          );
        },
        child: Icon(Icons.add)
      ),
    ); 
  }
}

