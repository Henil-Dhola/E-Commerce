import 'package:ecommerceassingment/Pages/DetailsScreen.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final String productTitle;
  final String productImage;

  CheckoutScreen({Key? key, required this.productTitle, required this.productImage}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;

  void _completeCheckout() {
    // Show Snackbar to indicate successful product delivery
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your product delivery is completed successfully!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Process'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.productImage,
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.productTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else {
                  // Check if it's the last step (Step 3) to show Snackbar
                  if (_currentStep == 2) {
                    _completeCheckout();
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: Text('Step 1'),
                  content: Container(
                    // Content of Step 1
                    child: Text('Step 1: Enter shipping information'),
                  ),
                  isActive: _currentStep == 0,
                ),
                Step(
                  title: Text('Step 2'),
                  content: Container(
                    // Content of Step 2
                    child: Text('Step 2: Select payment method'),
                  ),
                  isActive: _currentStep == 1,
                ),
                Step(
                  title: Text('Step 3'),
                  content: DetailScreen(
                    title: widget.productTitle,
                    image: widget.productImage,
                    price: 10.0,
                  ),
                  isActive: _currentStep == 2,

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
