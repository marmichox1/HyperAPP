import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // For the chart
import 'package:flutter_application_1/screens/rendezvous.dart';
import 'package:flutter_application_1/screens/traitement.dart';
import 'dart:math'; // For generating random values
import 'package:intl/intl.dart'; // For date formatting

class AuthPatient extends StatefulWidget {
  const AuthPatient({super.key});

  @override
  State<AuthPatient> createState() => _AuthPatientState();
}

class _AuthPatientState extends State<AuthPatient> {
  final user = FirebaseAuth.instance.currentUser!;

  List<double> generateBloodPressureData(String uid, int dataPoints) {
    final random = Random(uid.hashCode);
    return List.generate(
        dataPoints, (index) => 120 + random.nextInt(20).toDouble());
  }

  late List<double> dailyBloodPressure;
  late List<double> weeklyBloodPressure;
  late List<double> monthlyBloodPressure;
  late List<double> yearlyBloodPressure;

  String selectedView = 'Jour';

  @override
  void initState() {
    super.initState();
    dailyBloodPressure =
        generateBloodPressureData(user.uid, 24); // 24 points for hours
    weeklyBloodPressure =
        generateBloodPressureData(user.uid + "week", 7); // 7 points for days
    monthlyBloodPressure =
        generateBloodPressureData(user.uid + "month", 12); // 12 points for months
    yearlyBloodPressure =
        generateBloodPressureData(user.uid + "year", 5); // 5 points for years
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
      default: // 'Jour'
        return dailyBloodPressure;
    }
  }

  List<String> getXLabels() {
    final now = DateTime.now();
    switch (selectedView) {
      case 'Semaine':
        return [
          'Lundi',
          'Mardi',
          'Mercredi',
          'Jeudi',
          'Vendredi',
          'Samedi',
          'Dimanche',
        ];

      case 'Mois':
        return [
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre',
        ].sublist(0, now.month); // Show only months up to the current month

      case 'Année':
        return List.generate(5, (index) {
          return (now.year - index).toString(); // Get last 5 years
        }).toSet().toList(); // Convert to Set to remove duplicates

      default: // 'Jour'
        return [
          '00:00',
          '03:00',
          '06:00',
          '09:00',
          '12:00',
          '15:00',
          '18:00',
          '21:00',
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 138, 214, 1),
        title: Text(
          'Bienvenue, ${user.email!}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
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
            // Blood pressure container
            Container(
              padding: EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.favorite, color: Colors.red, size: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tension actuelle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${dailyBloodPressure.last} mmHg',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Dropdown and Chart container
            Container(
              padding: EdgeInsets.all(20), // Increased padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                  )
                ],
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
                            child: Text(
                              view,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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

                  // Line chart with grid lines and axes
                  SizedBox(
                    height: 250, // Increased height for better visibility
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          horizontalInterval: 5,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.3),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // No right Y-axis
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // No top X-axis
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                final xLabels = getXLabels();
                                final totalDataPoints =
                                    getCurrentBloodPressureData().length;

                                // Calculate step to evenly space the labels across the x-axis
                                int step = (totalDataPoints / xLabels.length)
                                    .ceil(); // Adjust step based on number of labels

                                final index = value.toInt();

                                // Show a label only if the index is a multiple of the step
                                if (index % step == 0 &&
                                    index ~/ step < xLabels.length) {
                                  return Text(
                                    xLabels[index ~/ step], // Get the corresponding label
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  );
                                }
                                return Container(); // Return empty for indices without labels
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                            left: BorderSide(color: Colors.black, width: 1),
                            right: BorderSide(
                                color: Colors.transparent, width: 0), // No right border
                            top: BorderSide(
                                color: Colors.transparent, width: 0), // No top border
                          ),
                        ),
                        minX: 0,
                        maxX: getCurrentBloodPressureData().length.toDouble() - 1,
                        minY: 100,
                        maxY: 140,
                        lineBarsData: [
                          LineChartBarData(
                            spots: getCurrentBloodPressureData()
                                .asMap()
                                .entries
                                .map((e) => FlSpot(e.key.toDouble(), e.value))
                                .toList(),
                            isCurved: true,
                            color: Color.fromRGBO(60, 138, 214, 1),
                            barWidth: 4,
                            belowBarData: BarAreaData(
                                show: true,
                                color: Color.fromRGBO(60, 138, 214, 1)
                                    .withOpacity(0.3)),
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
            color: Color.fromRGBO(60, 138, 214, 1),
            boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade300)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {},
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
                onPressed: () {},
              ),
            ],
          ),
        ),
       ),
    );
  }
}
