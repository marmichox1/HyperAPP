import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Pour le graph
import 'dart:math'; // Pour générer des valeurs aléatoires

class auth_patient extends StatefulWidget {
  const auth_patient({super.key});

  @override
  State<auth_patient> createState() => _auth_patientState();
}

class _auth_patientState extends State<auth_patient> {
  final user = FirebaseAuth.instance.currentUser!;
  
  
  List<double> generateBloodPressureData(String uid) {
    final random = Random(uid.hashCode); 
    return List.generate(7, (index) => 120 + random.nextInt(20).toDouble());
  }

 
  late List<double> dailyBloodPressure;
  late List<double> weeklyBloodPressure;
  late List<double> monthlyBloodPressure;
  late List<double> yearlyBloodPressure;

  String selectedView = 'Jour';

  @override
  void initState() {
    super.initState();
    dailyBloodPressure = generateBloodPressureData(user.uid);
    weeklyBloodPressure = generateBloodPressureData(user.uid + "week");
    monthlyBloodPressure = generateBloodPressureData(user.uid + "month");
    yearlyBloodPressure = generateBloodPressureData(user.uid + "year");
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  List<double> getCurrentBloodPressureData() {
    switch (selectedView) {
      case 'Semaine':
        return weeklyBloodPressure;
      case 'Mois':
        return monthlyBloodPressure;
      case 'Année':
        return yearlyBloodPressure;
      default:
        return dailyBloodPressure;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 138, 214, 100),
        title: Text('Bienvenue, ${user.email!}'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
            tooltip: 'Déconnexion',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite, color: Colors.red, size: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tension actuelle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('${dailyBloodPressure.last} mmHg', style: TextStyle(fontSize: 24, color: Colors.black87)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
           
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
              ),
              child: Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<String>(
                        value: selectedView,
                        items: ['Jour', 'Semaine', 'Mois', 'Année'].map((view) {
                          return DropdownMenuItem(
                            value: view,
                            child: Text(view),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedView = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  
                  
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: getCurrentBloodPressureData().asMap().entries.map((entry) {
                              return FlSpot(entry.key.toDouble(), entry.value);
                            }).toList(),
                            isCurved: true,
                            colors: [Color.fromRGBO(60, 138, 214, 100)],
                            barWidth: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          decoration: BoxDecoration(
            color: Color.fromRGBO(60, 138, 214, 100),
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {
                 
                },
              ),
              IconButton(
                icon: Icon(Icons.local_hospital, color: Colors.white),
                onPressed: () {
                 
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.white),
                onPressed: () {
                 
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
