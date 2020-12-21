import 'package:app_ranking_mounstros/models/monster.dart';
import 'package:app_ranking_mounstros/services/cloud_firestore_service.dart';
import 'package:app_ranking_mounstros/widgets/monster_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonsterDetail extends StatelessWidget {
  List<Monster> lista_mounstros;
  CloudFirestoreService firestoreService;
  MonsterDetail(
    this.lista_mounstros
  );
  
  @override
  Widget build(BuildContext context) {

    firestoreService = Provider.of<CloudFirestoreService>(context);

    return ListView.builder(
      itemCount: lista_mounstros.length,
      itemBuilder: (BuildContext context, int indice){
        Monster monster = lista_mounstros[indice];
        return ListTile(
          title:  Text(monster.nombre),
          subtitle:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(monster.caracteristicas.toString()),
              Text("Puntuacion: ${monster.puntuacion}"),
            ],
          ),
          leading: MonsterPhoto(monster.avatarURL, 100),
          trailing: MaterialButton(
            onPressed: () async {
              await firestoreService.asustar(monster.id);
            },
            child: Text("Ir a asustar"),
          ),
        );
      },
    );
  }
}