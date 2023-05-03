import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vedas/auth.dart';
import 'package:vedas/userinfo.dart';
import 'accountpage.dart';
import 'interestspage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = "";
  bool isLogin = true;

  final userRepo = Get.put(UserRepository());


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> createUser(UserModel user) async {
    try {
      await userRepo.createUser(user);
    } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
    }
  }
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
        setState(() {
          errorMessage = e.message;
        });
    }
  }

  Widget _logo() {
    return const Image(
      image: AssetImage('assets/purple3.png'),
      height: 200,
      width: 200,
    );
  }

  Widget _title() {
    return const Text(
      'VEDAS',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white30),
        labelText: title,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget errorMessageWidget() {
    return Text(
      errorMessage == '' ? '' : 'Hmm? $errorMessage!',
      style: const TextStyle(
        color: Colors.red,
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
      ),
      onPressed: () {
        if (isLogin) {
          signInWithEmailAndPassword();
        } else {
          createUser(UserModel(
              email: emailController.text,
              interests: <String, dynamic>{}));
          }
      },
      child: Text(style:TextStyle(color: Colors.white),
      isLogin ? 'Login' : 'Create Account'),
    );
  }

  Widget _LoginRegisterButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepPurple,
      ),
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      },
      child: Text(isLogin ? 'Create Account' : 'Login'),
    );
  }
  Widget _googlelogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        onPrimary: Colors.white,
      ),
      onPressed: () {
        Auth().signInWithGoogle().then((user) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AccountPage()),
          );
        }).catchError((e) {
          print('Error logging in with Google: $e');
        });
      },
      child: const Text('Sign in with Google'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff000000),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _logo(),
              const SizedBox(height: 20),
              _title(),
              const SizedBox(height: 20),
              _entryField('Email', emailController),
              _entryField('Password', passwordController),
              errorMessageWidget(),
              _submitButton(),
              const SizedBox(height: 20),
              _LoginRegisterButton(),
              _googlelogin()
            ],
          )
      ),
    );
  }
}
