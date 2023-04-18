import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vedas/pages/accountpage.dart';
import 'package:vedas/pages/homepage.dart';
import 'package:vedas/pages/interestspage.dart';
import 'package:vedas/pages/loginpage.dart';
import 'package:vedas/auth.dart';
import 'package:vedas/pages/videospage.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return HomePage();
          } else {
        return LoginPage();
      }
    });
  }
}
