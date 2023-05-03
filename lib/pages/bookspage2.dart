import 'package:flutter/material.dart';

import '../bottomnavbar.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  List<String> books = [
    'Protocols and Architectures for Wireless Sensor Networks',
    'Introductory methods of numerical analysis',
    'Theory and Problems of Probability and Statistics',
    'Applied Mathematics for Engineers and Physicists',
    'ADVANCED ENGINEERING MATHEMATICS',
    'Higher Engineering Mathematics',
    'Artificial Intelligence - Structures and Strategies for Complex Problem Solving',
    'Artificial Intelligence Illuminated',
    'Artificial Intelligence',
    'A Modern Approach',
    'Big Data Analytics From Strategic Planning to Enterprise Integration with Tools, Techniques, NoSQL, and Graph',
    'Big Data Analytics with R and Hadoop',
    'Business Intelligence for Dummies',
    'Business Intelligence',
    'The C Programming Language',
    'Structure and Interpretation of Computer Programs',
    'How To Solve It By Computer',
    'Practical "C" Programming',
    'Cloud Computing - Principles and Paradigms',
    'Discrete and Computational Geometry',
    'Computational Geometry - Algorithms and Application',
    'Parallel Computing architecture A hardware  software approach',
    'Advanced computer architecture and parallel processing',
    'Advanced Computer Architecture Parallelism, Scalability, Programmability',
    'Computer Organization and Architecture Designing for Performance 10th Edition'
  ];

  List<String> subjects = [
  "Advanced Wireless Sensor Networks",
  "Applied Mathematics",
  "Applied Mathematics",
  "Applied Mathematics",
  "Applied Mathematics",
  "Applied Mathematics",
  "Artificial Intelligence",
  "Artificial Intelligence",
  "Artificial Intelligence",
  "Artificial Intelligence",
  "Big Data Analytics and Business Intelligence",
  "Big Data Analytics and Business Intelligence",
  "Big Data Analytics and Business Intelligence",
  "Big Data Analytics and Business Intelligence",
  "C Programming",
  "C Programming",
  "C Programming",
  "C Programming",
  "C Programming",
  "Cloud Computing",
  "Computational Geometry",
  "Computational Geometry",
  "Computer Architecture",
  "Computer Architecture",
  "Computer Architecture",
  "Computer Architecture",
  "Computer Architecture",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: MyBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            textColor: Colors.white,
            minVerticalPadding: 10,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            leading: Icon(Icons.book, color: Colors.white),
            title: Text(books[index]),
            subtitle: Text(subjects[index]),
          );
        },
      ),
    );
  }
}
