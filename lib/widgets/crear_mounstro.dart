import 'package:app_ranking_mounstros/helpers/helpers.dart';
import 'package:app_ranking_mounstros/models/monster.dart';
import 'package:app_ranking_mounstros/services/cloud_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CrearMounstro extends StatelessWidget {
  
  String nombre;
  List<String> caracteristicas;
  String avatarURL;
  CloudFirestoreService firestoreService;
    
  @override
  Widget build(BuildContext context) {

    firestoreService = Provider.of<CloudFirestoreService>(context);
    
    return Form(
      child: Column(
        children: <Widget> [ 
          TextFormField(
            validator: (input) => input.isEmpty? 'Ingrese algún nombre' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              labelText: 'Nombre del mounstro'
            ),
            onChanged: (input) {
              nombre = input;
            },
          ),
          Container(
            height: 20,
          ),
          TextFormField(
            validator: (input) => input.isEmpty? 'Ingrese caracteristicas nombre' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              labelText: 'Características (separadas por coma)'
            ),
            onChanged: (input) {
              caracteristicas = input.split(',');
            },
          ),
          Container(
            height: 20,
          ),
          TextFormField(
            validator: (input) => input.isEmpty? 'Ingrese la url de su foto' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              labelText: 'Ingrese la url de su foto'
            ),
            onChanged: (input) {
              avatarURL = input;
            },
          ),
          MaterialButton(
            child: Text('Crear'),
            onPressed: () async {
              mostrarLoading(context);
              Monster mounstro = new Monster(
                nombre: nombre,
                caracteristicas: caracteristicas,
                avatarURL: avatarURL,
              );
              await firestoreService.crearMounstro(mounstro);
              Navigator.pop(context);
              Navigator.pop(context);
            }
          ),
        ]
      )
    );
  }
}