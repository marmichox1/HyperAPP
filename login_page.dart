import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}
bool ispassword = false;
Icon iconpass = const Icon(Icons.visibility_off,color: Colors.grey);


class _login_pageState extends State<login_page> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  Future singIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text.trim(), password: _passwordcontroller.text.trim());
  }

  @override
  void dispose (){
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(child:Center(child: SingleChildScrollView(child:
       Column(
        children: [
          Image.asset('images/logo.png',
          height: 150,),
          const SizedBox(height: 20,),
          const Text('Sing up',
          style: TextStyle(
            fontSize: 20
          ),
          ),
          const SizedBox(
            height: 50,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                
            
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _emailcontroller,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.grey,),
                    border: OutlineInputBorder(),
                    hintText: 'Email'
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(90),
                
            
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _passwordcontroller,
                  obscureText: ispassword ? false:true,
                  decoration:InputDecoration(
                    prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                    suffixIcon:IconButton(onPressed: (){
                      setState(() {
                        ispassword = !ispassword;
                        if (ispassword){
                          iconpass = const Icon(Icons.visibility,color: Colors.grey,);
                        }
                        else {
                          iconpass = const Icon(Icons.visibility_off,color: Colors.grey,);
                        }
                        
                      });
                    },icon: iconpass,),
                    
                    border: OutlineInputBorder(),
                    hintText: 'Mot de passe'
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
         const Text('Mot de passe oublié ?',
          style: TextStyle(
            color: Color.fromRGBO(60, 138, 214, 100),
            fontSize: 20,
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: singIn,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(60, 138, 214, 100),
                  borderRadius: BorderRadius.circular(20)
                ),
              
                child: Center(child: Text('Se connecter',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
              
                ),)),
                
              ),
            ),
          ),
          Divider(
            height: 100,
            thickness: 2,
            color: Colors.black,
            indent: 130,
            endIndent: 130,
          ),
          const SizedBox(height: 10,),
          const Text('Pas encore inscrits ?',
          style: TextStyle(
            color: Color.fromRGBO(60, 138, 214, 100),
            fontSize: 20,
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(60, 138, 214, 100),
                borderRadius: BorderRadius.circular(20)
              ),

              child: Center(child: Text("Je m'inscris",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,

              ),)),
              
            ),
          ),











        ],
      ), ),))

    );
  }
}