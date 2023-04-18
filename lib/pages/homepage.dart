import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bookspage.dart';
import 'videospage.dart';
import 'accountpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VEDAS'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                  fixedSize: Size.infinite,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideosPage()),
                  );
                },
                icon: Icon(Icons.video_collection),
                label: Text('Videos'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  fixedSize: Size.infinite,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BooksPage()),
                  );
                },
                icon: Icon(Icons.book),
                label: Text('Books'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[200],

                  fixedSize: Size.infinite,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
                icon: Icon(Icons.account_circle),
                label: Text('Account'),
              ),
            ),
            SizedBox(height:20),
          ],
        ),
      ),
    );
  }
}
