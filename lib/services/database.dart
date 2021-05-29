import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String uid;
  DataBaseService({this.uid});
  final CollectionReference userData= Firestore.instance.collection('userd');

  Future updateUserData(String name,int phonenumber) async{
    return await userData.document(uid).setData({
      'Name': name,
      'Phone number':phonenumber,
    });
  }
  Stream<QuerySnapshot> get userd{
    return userData.snapshots();
  }
}