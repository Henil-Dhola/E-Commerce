import 'package:ecommerceassingment/Pages/CategoryPage.dart';
import 'package:ecommerceassingment/Pages/DetailsScreen.dart';
import 'package:ecommerceassingment/Pages/HomeScreen.dart';
import 'package:ecommerceassingment/Pages/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "E-Commerce",
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink.shade50),
        ),
        centerTitle: true,
      ),
      body: _buildBody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }

  // Method to build body based on current index
  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return CategoryPage();
      case 2:
        final email = FirebaseAuth.instance.currentUser?.email;
        return ProfileScreen(email!);
      default:
        return SizedBox.shrink();
    }
  }
}
