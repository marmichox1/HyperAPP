import 'package:flutter/material.dart';
class Traitement extends StatefulWidget {
  const Traitement({super.key});

  @override
  State<Traitement> createState() => _TraitementState();
}

class _TraitementState extends State<Traitement> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 138, 214, 1),
        title: Center(
          child: Text(
            'Rendez vous, ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: Colors.white),
            
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.logout),
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column()
      ),);
  }
}