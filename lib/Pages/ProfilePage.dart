import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceassingment/LoginPage.dart';
import 'package:ecommerceassingment/Pages/ProfileMenu.dart';
import 'package:ecommerceassingment/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class ProfileScreen extends StatelessWidget {
  final String email;
  ProfileScreen(this.email);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/image/person.png"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Welcome", style: Theme.of(context).textTheme.headline4),
              //Text(email, style: Theme.of(context).textTheme.bodyText2),
              FutureBuilder<DocumentSnapshot>(
                future: getUsernameFromUserCollection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('User data not found');
                  }
                  final username = snapshot.data!['Fullname'];
                  return Text(username);
                },
              ),
              const SizedBox(height: 20),

              /// -- BUTTON

              const SizedBox(height: 30),

              const Divider(),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed:(){
                  AuthenticationHelper()
                      .signOut()
                      .then((_) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (contex) => LoginPage()),
                  ).then((_) => Navigator.pop(context))
                  );
                },
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<DocumentSnapshot> getUsernameFromUserCollection() async {
  final user = FirebaseAuth.instance.currentUser;
  final email = user!.email;

  // Querying the 'Users' collection for the user's email
  final userQuerySnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .where('Email', isEqualTo: email)
      .get();

  // Checking if the query returned any documents
  if (userQuerySnapshot.docs.isNotEmpty) {
    // Retrieving the user document
    return userQuerySnapshot.docs.first;
  } else {
    throw Exception('User data not found');
  }
}
