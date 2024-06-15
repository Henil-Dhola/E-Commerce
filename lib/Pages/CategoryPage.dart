import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceassingment/Pages/CheckoutScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String image;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
}

class CategoryPage extends StatelessWidget {
  late final int productIndex;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: fetchCartItemsFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final cartItems = snapshot.data ?? [];
          return Scaffold(
            appBar: AppBar(
              title: Text('Cart Items'),
              centerTitle: true,
            ),
            body: cartItems.isEmpty
                ? Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Dismissible(
                  key: Key(cartItem.id), // Unique key for each item
                  onDismissed: (direction) async {
                    // Remove the item from Firestore when dismissed
                    final user = FirebaseAuth.instance.currentUser;
                    final email = user!.email;
                    final firestore = FirebaseFirestore.instance;
                    await firestore
                        .collection('cart')
                        .doc(cartItem.id)
                        .delete();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${cartItem.title} removed from cart'),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: Image.network(
                        cartItem.image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        cartItem.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '\$${cartItem.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.share_location),
                        onPressed: () {
                          // Navigate to the checkout screen when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen( productTitle: cartItem.title,productImage:cartItem.image),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<List<CartItem>> fetchCartItemsFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user!.email;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore
        .collection('cart')
        .where('email', isEqualTo: email)
        .get();

    final List<CartItem> cartItems = [];
    querySnapshot.docs.forEach((doc) {
      cartItems.add(CartItem(
        id: doc.id,
        title: doc['title'],
        price: doc['price'],
        image: doc['image'],
      ));
    });
    return cartItems;
  }
}
