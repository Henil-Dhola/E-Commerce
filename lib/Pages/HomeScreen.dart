import 'package:ecommerceassingment/Pages/DetailsScreen.dart';
import 'package:flutter/material.dart';
class Product {
  final String title;
 // final String description;
  final String image;
  final double price;

  Product({
    required this.title,
  //  required this.description,
    required this.image,
    required this.price,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {
      "title": "white sneaker with adidas logo",
      "price": "\$255",
      "images":
      "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=725&q=80",
    },
    {
      "title": "Black Jeans with blue stripes",
      "price": "\$245",
      "images":
      "https://images.unsplash.com/photo-1541099649105-f69ad21f3246?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Red shoes with black stripes",
      "price": "\$155",
      "images":
      "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvZXN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    },
    {
      "title": "Gamma shoes with beta brand.",
      "price": "\$275",
      "images":
      "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Alpha t-shirt for alpha testers.",
      "price": "\$25",
      "images":
      "https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "Beta jeans for beta testers",
      "price": "\$27",
      "images":
      "https://images.unsplash.com/photo-1602293589930-45aad59ba3ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },
    {
      "title": "V&V  model white t shirts.",
      "price": "\$55",
      "images":
      "https://images.unsplash.com/photo-1554568218-0f1715e72254?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
    },

    {
      "title": "Rolex Gold Daytona",
      "price": "\$83.94",
      "images":
      "https://dillibazar.co.in/wp-content/uploads/FB_IMG_1449484704641.jpg",
    },
    {
      "title": "Apple Watch Ultra 2 GPS + Cellular",
      "price": "\$1030.18",
      "images":
      "https://www.aptronixindia.com/media/catalog/product/cache/31f0162e6f7d821d2237f39577122a8a/t/i/titanium_orange_ocean_band_pdp_image_position-1__en-us-removebg-preview_1.png",
    },
    {
      "title": "Virat Kohli 18 New Ind Cricket Team Jersey 2023",
      "price": "\$3.65",
      "images":"https://m.media-amazon.com/images/I/51crHGGTpyL._AC_UL320_.jpg"
    },
    {
      "title": "MI Cricket Team Jersey Rohit Sharma 45",
      "price": "\$5.02",
      "images":"https://m.media-amazon.com/images/I/517aiEAboML._AC_UL320_.jpg"
    },
    {
      "title": "Apple iPhone 15 Pro Max (256GB, Blue Titanium)",
      "price": "\$1917.65",
      "images":"https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1708678829/Croma%20Assets/Communication/Mobiles/Images/300822_0_vy3iid.png?tr=w-360"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
       // physics: const NeverScrollableScrollPhysics(),// Add padding around the GridView
       // shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 310,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Handle the click event here
              // For example, you can navigate to a new screen or perform any other action
              print("Card clicked: ${products[index]['title']}");
              Navigator.push(context,MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: products[index]['title'],
                  image: products[index]['images'],
                  price: double.parse(products[index]['price'].substring(1)),
                ),
              ),);
            },
            child: Card(
              elevation: 4, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Add border radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                      child: Image.network(
                        "${products.elementAt(index)['images']}",
                        height: 170,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${products.elementAt(index)['title']}",
                          style: Theme.of(context).textTheme.subtitle1!.merge(
                            const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(
                              "${products.elementAt(index)['price']}",
                              style: Theme.of(context).textTheme.subtitle2!.merge(
                                TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      ),
    );
  }

}
