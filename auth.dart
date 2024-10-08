import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth_patient.dart';
import 'package:flutter_application_1/screens/login_page.dart';



class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder: ((context,snapshot){
          if (snapshot.hasData){
              return auth_patient();
          }
          else {
            return login_page();
          }
      })),
    );
  }
}