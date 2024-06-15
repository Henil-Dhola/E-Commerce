import 'package:ecommerceassingment/Pages/CategoryPage.dart';
import 'package:ecommerceassingment/Pages/CheckoutScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
class CartItem {
  final String title;
  final String image;
  final double price;

  CartItem({
    required this.title,
    required this.image,
    required this.price,
  });
}

class DetailScreen extends StatefulWidget {
  final String title;
  final String image;
  final double price;

  DetailScreen({
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _quantity = 1;
  List<CartItem> cartItems = []; // List to store added products

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    setState(() {
      cartItems.add(CartItem(
        title: widget.title,
        image: widget.image,
        price: widget.price * _quantity, // Adjusted to include quantity
      ));
      final user = FirebaseAuth.instance.currentUser;
      final email = user!.email;
      // FirebaseFirestore.instance
      //     .collection('Users')
      //     .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email).get();
      FirebaseFirestore.instance.collection('cart')
          .add({
        'title': widget.title,
        'image': widget.image,
        'price': widget.price * _quantity,
        'email':email,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green), // Icon indicating success
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${widget.title} added to cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.blue, // Custom background color
          duration: Duration(seconds: 2), // Set duration for the snackbar
          behavior: SnackBarBehavior.floating, // Make the snackbar floating
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          elevation: 4, // Add elevation
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Product Details", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.pink.shade50)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.shade100,
                ),
                margin: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        '\$${(widget.price * _quantity).toStringAsFixed(2)}', // Displaying total price
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _decrementQuantity,
                          icon: Icon(Icons.remove),
                        ),
                        Text(
                          '$_quantity',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: _incrementQuantity,
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${(widget.price * _quantity).toStringAsFixed(2)}', // Displaying total price
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _addToCart();
                },
                icon: Icon(Icons.shopping_cart_checkout),
                label: Text("Add to Cart"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
