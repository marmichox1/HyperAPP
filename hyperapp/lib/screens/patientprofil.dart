import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/screens/appbar_widget.dart';
import 'package:flutter_application_1/screens/auth_patient.dart';
import 'package:flutter_application_1/screens/button_widget.dart';
import 'package:flutter_application_1/screens/edit_profile_page.dart';
import 'package:flutter_application_1/screens/numbers_widget.dart';
import 'package:flutter_application_1/screens/profile_widget.dart';
import 'package:flutter_application_1/screens/rendezvous.dart';
import 'package:flutter_application_1/screens/traitement.dart';
import 'package:flutter_application_1/screens/user_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user_now = UserPreferences.myUser;

    return  Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user_now.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              buildName(user_now),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              
              const SizedBox(height: 48),
              
            ],
          ),
          bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(60, 138, 214, 1),
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthPatient()),
            );},
              ),
              IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Rendezvous()),
            );},
              ),
              IconButton(
                icon: Icon(Icons.local_hospital, color: Colors.white),
                onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Traitement()),
            );
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );},
              ),
            ],
          ),
        ),
       ),
        
      
    );
  }

  Widget buildName(User_now user_now) => Card(
    child: Column(
          children: [
            Text(
              user_now.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.prenom,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.adresse,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.email,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.age,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.tel,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              user_now.email,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
  );

  Widget buildUpgradeButton() => ButtonWidget(
        text: '',
        onClicked: () {},
      );

  Widget buildAbout(User_now user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
