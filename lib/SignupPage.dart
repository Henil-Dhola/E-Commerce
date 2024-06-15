import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceassingment/LoginPage.dart';
import 'package:ecommerceassingment/User_model.dart';
import 'package:ecommerceassingment/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late Color myColor;
  late Size mediaSize;
  String? email;
  String? password;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController=TextEditingController();
  final _db=FirebaseFirestore.instance;
  //store data in firestore
  createUser(user_model usermodel) async {
    await _db.collection("Users").add(usermodel.toJson()).whenComplete(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Your Account has been Created Successully..!",
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),backgroundColor: Colors.green,behavior: SnackBarBehavior.floating,))
    ).catchError((e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong ,Please Try again..!",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),backgroundColor: Colors.red,behavior: SnackBarBehavior.floating,));
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/image/resturant.jpg"),
          fit: BoxFit.cover,
          colorFilter:
          ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 80, child: _buildTop()),
            Positioned(bottom: 0, child: _buildButtom()),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/image/checklist.png", height: 90),
          Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildButtom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("Create your account"),
        const SizedBox(height: 30),
        _buildGreyText("Name "),
        _buildInputField(nameController),
        const SizedBox(height: 30),
        _buildGreyText("Email address"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildSignupButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }


  Widget _buildSignupButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          // Perform signup logic here
          final user = user_model(nameController.text, emailController.text, passwordController.text);

          // Sign up user using Firebase Authentication
          await AuthenticationHelper().signUp(email: emailController.text, password: passwordController.text);

          // Store additional user data in Firestore
          await createUser(user);

          // Navigate to login page after successful signup
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              e.toString(),
              style: TextStyle(fontSize: 16),
            ),
          ));
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("SIGN UP"),
    );
  }

}



