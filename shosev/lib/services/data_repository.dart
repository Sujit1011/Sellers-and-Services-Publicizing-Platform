import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, DocumentReference, FirebaseFirestore, QuerySnapshot;
import 'package:shosev/models/SS_Service.dart' show SS_Service;
import 'package:shosev/models/SS_Shop.dart' show SS_Shop;
import 'package:shosev/models/SS_User.dart' show SS_User;

class DataRepository {
  
  final CollectionReference ss_users_collection = FirebaseFirestore.instance.collection('ss_users');
  final CollectionReference ss_shops_collection = FirebaseFirestore.instance.collection('ss_shops');
  final CollectionReference ss_services_collection = FirebaseFirestore.instance.collection('ss_services');

  // ss_users
  Stream<QuerySnapshot> getStream_SS_User() {
    return ss_users_collection.snapshots();
  }
  Future<DocumentReference> add_SS_User(SS_User user) {
    return ss_users_collection.add(user.toJson());
  }
  void update_SS_User(SS_User user) async {
    await ss_users_collection.doc(user.uid).update(user.toMap());
  }
  void delete_SS_User(SS_User user) async {
    await ss_users_collection.doc(user.uid).delete();
  }

  // ss_shops
  Stream<QuerySnapshot> getStream_SS_Shop() {
    return ss_shops_collection.snapshots();
  }
  Future<DocumentReference> add_SS_Shop(SS_Shop ss_shop) {
    return ss_shops_collection.add(ss_shop.toJson());
  }
  void update_SS_Shop(SS_Shop ss_shop) async {
    await ss_shops_collection.doc(ss_shop.id).update(ss_shop.toMap());
  }
  void delete_SS_Shop(SS_Shop ss_shop) async {
    await ss_shops_collection.doc(ss_shop.id).delete();
  }

  // ss_services
  Stream<QuerySnapshot> getStream_SS_Service() {
    return ss_services_collection.snapshots();
  }
  Future<DocumentReference> add_SS_Servicer(SS_Service ss_service) {
    return ss_services_collection.add(ss_service.toJson());
  }
  void update_SS_Service(SS_Service ss_service) async {
    await ss_services_collection.doc(ss_service.id).update(ss_service.toMap());
  }
  void delete_SS_Service(SS_Service ss_service) async {
    await ss_services_collection.doc(ss_service.id).delete();
  }
}