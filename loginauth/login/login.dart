import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/loginauth/firebase/connectfirebase.dart';
import 'package:first_app/homepage.dart';

import 'package:first_app/loginauth/login/signup.dart';
import 'package:first_app/loginauth/toastmessage/toastmessage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



//  this login gade will be modifing by sure becuse it is just giving authorization to the user which have ther data in server
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailAdd = TextEditingController();

  bool _isSign = false;

  TextEditingController _passwordAdd = TextEditingController();
  @override
  void dispose() {
    _emailAdd.dispose();

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
                  onPressed: _login,
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
                  child: const Text("Login In"),
                ),
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.login),
                ElevatedButton(
                  onPressed: _signInWithGoogle,
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
                  child: const Text('Sign In with Google'),
                ),
              ]),
              const SizedBox(
                height: 8.0,
              ),
              const Text("Dont have an Account?"),
              const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: _isSign
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Login"),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void _login() async {
    setState(() {
      _isSign = true;
    });

    String email = _emailAdd.text;
    String pass = _passwordAdd.text;

    User? user = await _auth.loginInEpPass(email, pass);
    setState(() {
      _isSign = false;
    });
    if (user != null) {
      showToast(message: "sucessfully login");
      // print("sucessfully login");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  Homepage()),
          ((route) => false));
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

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>  Homepage(),
            ),
            (route) => false);
      }
    } catch (e) {
      showToast(message: "Something Went Wrong $e");
    }
  }
}
