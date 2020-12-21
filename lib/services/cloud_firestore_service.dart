import 'package:app_ranking_mounstros/models/monster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  final String MONSTERS = "monsters";

  Stream<QuerySnapshot> streamMonstersData() => 
    _db.collection(MONSTERS).where('caracteristicas', arrayContainsAny: ["Color azul", "Es color azul"]).snapshots();

  List<Monster> mostrarMounstrous(List<DocumentSnapshot> snapshots){
    List<Monster> mounstros = List<Monster>();
    DateTime now = DateTime.now();
    if(snapshots.isNotEmpty){
      snapshots.forEach((snapshot) { 
        Map<String, dynamic> data = snapshot.data();
        mounstros.add(
          Monster(
            nombre: data['nombre'] ?? "",
            caracteristicas: data['caracteristicas'] != null ? List<String>.from(data['caracteristicas']) : List<String>(),
            avatarURL: data['avatarURL'] ?? "",
            puntuacion: data['puntuacion'] ?? "",
            id: data['id'] ?? "",
            fechaInscripcion: data['fechaInscripcion'].toDate()
          )
        );
      });
    }
    return mounstros;
  }
  Future<void> crearMounstro(Monster mounstro) async{
    DocumentReference mounstroRef = await _db.collection(MONSTERS).add({
      'nombre': mounstro.nombre,
      'caracteristicas': mounstro.caracteristicas,
      'avatarURL': mounstro.avatarURL,
      'puntuacion': 0,
      'fechaInscripcion': DateTime.now()
    });
    await mounstroRef.update({
      'id': mounstroRef.id
    });
  }
  Future<void> asustar(String mounstroId) async{
    
    DocumentReference ref = _db.collection(MONSTERS).doc(mounstroId);
    DocumentSnapshot snapshot = await ref.get();
    int puntuacion = snapshot.data()['puntuacion'];

    await ref.update({
      'puntuacion': puntuacion + 10
    });
  }
}