import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/screens/auth_patient.dart';
import 'package:flutter_application_1/screens/traitement.dart';
import 'package:intl/intl.dart';

class Rendezvous extends StatefulWidget {
  const Rendezvous({super.key});

  @override
  State<Rendezvous> createState() => _RendezvousState();
}

class _RendezvousState extends State<Rendezvous> {
  final now = DateTime.now();
  List days = ['25/10/2024','09/01/2025','15/03/2025','16/09/2025','14/12/2025'];
  List hours = ['15:20','10:30','14:30','16:20','09:20'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(60, 138, 214, 1),
        title: const Center(
          child: Text(
            'Rendez-vous',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5, // Simulating 5 rendezvous for now
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
                      'Rendez-vous avec le docteur ${index + 1}',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Date: ${days[index]}',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Heure: ${hours[index]}',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: Colors.grey[700],
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
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.local_hospital, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Traitement()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
