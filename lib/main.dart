import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vedas/pages/accountpage.dart';
import 'package:vedas/pages/loginpage.dart';
import 'package:vedas/widget_tree.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => AccountPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepPurple,
      ),
      home: const WidgetTree(),
    );
  }
}