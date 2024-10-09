import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class auth_patient extends StatefulWidget {
  const auth_patient({super.key});

  @override
  State<auth_patient> createState() => _auth_patientState();
}

class _auth_patientState extends State<auth_patient> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text('hello'),
          Text (user.email!),
        ],
      )),
    );
  }
}