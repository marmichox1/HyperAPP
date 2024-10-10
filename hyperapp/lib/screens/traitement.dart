import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/patientprofil.dart';
import 'package:flutter_application_1/screens/rendezvous.dart';
import 'package:flutter_application_1/screens/auth_patient.dart';

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
        backgroundColor: const Color.fromRGBO(60, 138, 214, 1),
        title: const Center(
          child: Text(
            'Traitements',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Simulating 5 treatments for now
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Traitement pour l\'hypertension',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Prenez 1 comprimé par jour, après le petit-déjeuner.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Durée: 3 mois',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(60, 138, 214, 1),
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Rendezvous()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.local_hospital, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
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
}
