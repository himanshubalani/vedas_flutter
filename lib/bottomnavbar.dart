import 'package:flutter/material.dart';
import 'package:vedas/pages/accountpage.dart';
import 'package:vedas/pages/bookspage2.dart';
import 'package:vedas/pages/videospage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    VideosPage(),
    BooksPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(
        icon: Icon(Icons.video_library, color: Colors.red[200],),
        label: 'Videos',
        backgroundColor: Colors.grey[900],
        activeIcon: Icon(Icons.video_library, color: Colors.red[200]),
       ),
        BottomNavigationBarItem(
        icon: Icon(Icons.book,color: Colors.blue[200]),
        label: 'Books',
        backgroundColor: Colors.grey[900],
        activeIcon: Icon(Icons.book, color: Colors.blue[200]),
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.account_circle, color: Colors.deepPurple[200]),
        label: 'Account',
        backgroundColor: Colors.grey[900],
        activeIcon: Icon(Icons.account_circle, color: Colors.deepPurple[200]),
        ),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _children[_currentIndex]),
      );
      _currentIndex = index;
    });
  }
}