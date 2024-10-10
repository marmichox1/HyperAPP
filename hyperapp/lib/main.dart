import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth.dart';
import 'package:flutter_application_1/screens/auth_patient.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/new_patient.dart';
import 'package:flutter_application_1/screens/user_preferences.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBcMNjt2X5TvIH9ZzoJrwyEqPv9a8mmO9A', 
      appId: '1:952160316805:android:de7c62f406f698cbaba8ec',
       messagingSenderId: '952160316805',
        projectId: 'hyperapp-84822')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user_now = UserPreferences.myUser;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
  
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const Auth(),
      routes: {
        '/':(context) => const Auth(),
        'login_page':(context) => const login_page(),
        'auth_patient':(context)=> const AuthPatient(),
        'sing_up':(context)=>  RegisterPage(),
        },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
  
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
