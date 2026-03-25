import 'dart:async';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_doctor_appointment/features/home/widgets/notificationList.dart';
import 'package:health_and_doctor_appointment/model/cardModel.dart';
import 'package:health_and_doctor_appointment/features/home/widgets/carouselSlider.dart';
import 'package:health_and_doctor_appointment/features/doctor/screens/exploreList.dart';
import 'package:health_and_doctor_appointment/features/home/widgets/topRatedList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../search/searchList.dart';

// Moved to features/home/screens/home_page.dart as part of feature-based organization.
// Please update your imports to use:
// import 'features/home/screens/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _doctorName = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    setState(() {
      user = _auth.currentUser;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _message;
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 5 && hour < 12) {
      _message = 'Good Morning';
    } else if (hour >= 12 && hour <= 17) {
      _message = 'Good Afternoon';
    } else {
      _message = 'Good Evening';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // محاذاة أفضل للطرفين
            children: [
              Text(
                _message,
                style: GoogleFonts.lato(
                  color: Colors.black54,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                splashRadius: 20,
                icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87), // أيقونة أرق
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationList()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: ListView(
            physics: const BouncingScrollPhysics(), // حركة أكثر سلاسة
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: <Widget>[
              const SizedBox(height: 10),

              // قسم الترحيب
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ${user?.displayName?.split(' ')[0] ?? 'User'}", // عرض الاسم الأول فقط لجمالية أكثر
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Let's Find Your\nDoctor",
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.2, // تقليل المسافة بين السطرين
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // حقل البحث
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _doctorName,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Search doctor...',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black26,
                      fontSize: 16,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white, size: 20),
                          onPressed: () {
                            if (_doctorName.text.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchList(searchKey: _doctorName.text)),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  onFieldSubmitted: (String value) {
                    if (value.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchList(searchKey: value),
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              // قسم Carousel
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We care for you",
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Carouselslider(),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // قسم Specialists
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Specialists",
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 15, bottom: 10),
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(cards[index].cardBackground),
                            boxShadow: [
                              BoxShadow(
                                color: Color(cards[index].cardBackground).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExploreList(
                                    type: cards[index].doctorType,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                  radius: 28,
                                  child: cards[index].cardIcon is IconData
                                      ? Icon(
                                    cards[index].cardIcon,
                                    size: 26,
                                    color: Color(cards[index].cardBackground),
                                  )
                                      : FaIcon(
                                    cards[index].cardIcon,
                                    size: 26,
                                    color: Color(cards[index].cardBackground),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  cards[index].doctorType,
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // قسم Top Rated
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Top Rated Doctors",
                      style: GoogleFonts.lato(
                          color: Colors.blue[800],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const TopRatedList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}