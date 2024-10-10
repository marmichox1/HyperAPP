import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes.dart';


AppBar buildAppBar(BuildContext context) {
   final user = FirebaseAuth.instance.currentUser!;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;
 void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }
  return AppBar(
        backgroundColor: Color.fromRGBO(60, 138, 214, 1),
        title: Text(
            'Profil',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
            tooltip: 'Déconnexion',
          ),
        ],
      );
}
