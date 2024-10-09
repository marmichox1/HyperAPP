import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class auth_patient extends StatefulWidget {
  static const String Screenroute =  'auth_patient';
  const auth_patient({super.key});

  @override
  State<auth_patient> createState() => _auth_patientState();
}

class _auth_patientState extends State<auth_patient> {
  final user_inst = FirebaseAuth.instance;
  final _filestore = FirebaseFirestore.instance;
  late User singedinuser;
void get_notification() async{
  _filestore.collection('notification').get();
  final notifications = await _filestore.collection('notification').get();
  for (var notification in notifications.docs){
    
      print(notification.data());
  }
}
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
  }
 void getcurrentuser(){
  try {
    final user = user_inst.currentUser;
  if (user !=null){
    singedinuser = user;
  }} catch (e) {
    print(e);
  }
  
  
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text('hello'),
          Text (singedinuser.email!),
          IconButton(onPressed: get_notification, icon: Icon(Icons.download))
        ],
      )),
    );
  }
}