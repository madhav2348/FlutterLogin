import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/loginauth/firebase/connectfirebase.dart';
import 'package:first_app/homepage.dart';
import 'package:first_app/loginauth/login/login.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
//ths class needed to edit to send sand store the data on server h

class _SignUpState extends State<SignUp> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailAdd = TextEditingController();

  TextEditingController _userName = TextEditingController();

  TextEditingController _passwordAdd = TextEditingController();
  bool _isLog = false;
  @override
  void dispose() {
    _emailAdd.dispose();
    _userName.dispose();
    _passwordAdd.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return (MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _userName, // create a variable to store the email
                decoration: const InputDecoration(
                  labelText: 'Username',
                  suffixText: "Use Name",
                ),
              ),
              TextField(
                controller: _emailAdd, // create a variable to store the email
                decoration: const InputDecoration(
                  labelText: 'Email',
                  suffixText: "Email",
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _passwordAdd, // create a varible to store password
                decoration: const InputDecoration(
                  labelText: 'Password',
                  suffixText: "Password",
                ),
                obscureText: true,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: _signup,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(color: Colors.white),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                     alignment: Alignment.center, 
                  ),

                  // onPressed: (() => Navigator.pushReplacement(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             LoginPage(), // create a funtion for login "_signing"// but for noe im redireting to homepage
                  //       ),
                  //     )),
                  child: _isLog ?const CircularProgressIndicator(color: Colors.white,) :const Text("Sign Up"),
                ),
              ),
             const SizedBox(
                height: 8.0,
              ),
             const Text("Aready have an Account?"),
             const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>  LoginPage()));
                },
                child:const Text("Login"),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _signup() async {
    setState(() {
       
  _isLog = true;
    });


    String name = _userName.text;
    String email = _emailAdd.text;
    String pass = _passwordAdd.text;

    User? user = await _auth.signUpEpPass(email, pass);
    setState(() {
      _isLog = false;
    });
    if (user != null) {
      print("sucessfully signing");
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Homepage()),((route) => false));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Ivalid Input'),
                content: const Text('Make sure  valid input'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ));
    }
  }
}
