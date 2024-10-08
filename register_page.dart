import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final bool isDoctor;

  RegisterPage({required this.isDoctor});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _permitNumberController = TextEditingController();
  String? selectedDoctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Logo
            Center(child: Icon(Icons.local_hospital, size: 100, color: Color(0xFF3e8ad1))),
            SizedBox(height: 24),
            
            // Full Name
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Nom complet',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Password
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Confirm Password
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmer le mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Address
            if (!widget.isDoctor)
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 16),
            
            // Phone Number
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Doctor Dropdown for Patients
            if (!widget.isDoctor)
              DropdownButtonFormField<String>( 
                value: selectedDoctor,
                items: ['Dr. Smith', 'Dr. Brown', 'Dr. Johnson'].map((doctor) {
                  return DropdownMenuItem(
                    value: doctor,
                    child: Text(doctor),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDoctor = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Sélectionnez votre médecin',
                  border: OutlineInputBorder(),
                ),
              ),
            
            // Permit Number for Doctors
            if (widget.isDoctor)
              TextField(
                controller: _permitNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de permis',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 16),
            
            // Register Button
            ElevatedButton(
              onPressed: () {
                // Fonctionnalité d'inscription
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF3e8ad1),
              ),
              child: Text('S\'inscrire'),
            ),
            SizedBox(height: 16),
            
            // Google Registration
            ElevatedButton.icon(
              onPressed: () {
                // Fonctionnalité d'inscription avec Google
              },
              icon: Icon(Icons.login),
              label: Text('S\'inscrire avec Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            
            // Switch to Login
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(isDoctor: widget.isDoctor)),
                );
              },
              child: Text(
                "Vous avez déjà un compte ? Connexion",
                style: TextStyle(color: Color(0xFF3e8ad1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
