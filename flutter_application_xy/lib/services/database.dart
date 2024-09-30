import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods{
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id)async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .set(userInfoMap);
  }

  Future addUserReserva(Map<String, dynamic> userInfoMap)async{
    return await FirebaseFirestore.instance
    .collection("Reserva") 
    .add(userInfoMap);
  }
  Future<Stream<QuerySnapshot>> getBookings()async{
    return await FirebaseFirestore.instance.collection("Reserva").snapshots();
  }

  DeleteReserva(String id)async{
    return await FirebaseFirestore.instance
        .collection("Reserva") 
        .doc(id)
        .delete();
  }
}
