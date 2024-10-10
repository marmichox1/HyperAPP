import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Rendezvous extends StatefulWidget {
  const Rendezvous({super.key});

  @override
  State<Rendezvous> createState() => _RendezvousState();
}

class _RendezvousState extends State<Rendezvous> {
   final user_inst = FirebaseAuth.instance;
  final _filestore = FirebaseFirestore.instance;
  late User singedinuser;
void get_notification() async{
  _filestore.collection('notification').get();
  await for (var snapshot  in _filestore.collection('notification').snapshots()){
    for (var notification in snapshot.docs){
      print(notification);


    }
  }
}
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentuser();
  }
 void getcurrentuser(){
  try {
    final user = user_inst.currentUser;
  if (user !=null){
    singedinuser = user;
  }} catch (e) {
    print(e);
  }
  
  
 }

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
      body: 
      Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Container(color: Colors.grey[200],
      padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Jour',
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    shape: CircleBorder(),
                    shadowColor: Colors.white,
                    
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose date',
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '12 Dec - 22 Dec',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of Rooms',
                      style: GoogleFonts.nunito(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 Room - 2 Adults',
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
          Text('hello'),
          Text (singedinuser.email!),
          IconButton(onPressed: get_notification, icon: Icon(Icons.download)),
          StreamBuilder<QuerySnapshot>(stream: _filestore.collection('notification').snapshots(), builder: (context,snapshot){
            List<Text> notificationwidgets = [];
            if (snapshot.hasData){
                
              }
            final notifications =snapshot.data!.docs;
            for (var notification in notifications) {
              final nottext = notification.get('description');
              final nottype = notification.get('type');
              
              final notuser = notification.get('user');
              final notificationwidget = Text('$nottext - $nottype - $notuser');
              notificationwidgets.add(notificationwidget);
              
            }
            return Column(
              
              children: 
                notificationwidgets,
            );
          }),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      )
      ),
      
      );
  }
}