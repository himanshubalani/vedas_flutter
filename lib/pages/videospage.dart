import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vedas/pages/accountpage.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vedas/pages/interestspage.dart';
import 'package:get/get.dart';

import '../bottomnavbar.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final _userInterests = <String>[].obs; // Observed list of user interests
  static String api_key = "AIzaSyCbarHxi3CLbiJIyb_zCPidb36aaWE9PwI";
  List<YouTubeVideo> results = [];
  YoutubeAPI yt = YoutubeAPI(api_key, maxResults: 10, type: "video");
  bool isLoaded = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    // Get the user interests
    final interests = await getUserInterests();
    _userInterests.assignAll(interests);

    // Set the search query to include the user interests
    setState(() {
      searchQuery = _userInterests.join(' '); // Combine interests into a single string
    });

    try {
      results = await yt.search(searchQuery);
      print(results);
      setState(() {
        isLoaded = true;
      });
    } catch (e) {
      print(e);
    }
  }




@override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white),
      child: Scaffold(
        bottomNavigationBar: MyBottomNavigationBar(),
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            "VIDEOS",
            style: TextStyle(color: Colors.black, fontFamily: "Poppins"),
          ),
          centerTitle: true,
        ),
        body: isLoaded
            ? ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(results[index].url);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: (Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 40,
                                  color: Colors.red.withOpacity(0.23))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Image.network(
                                results[index].thumbnail.medium.url!,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      results[index].title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                  top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    results[index].duration!,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              )),
            );
          },
          itemCount: results.length,
        )
            : Center(
          child: SleekCircularSlider(
            appearance: CircularSliderAppearance(
              spinnerMode: true,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}