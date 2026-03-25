// Moved to features/home/screens/main_page.dart as part of feature-based organization.
// Please update your imports to use:
// import 'features/home/screens/main_page.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health_and_doctor_appointment/features/user/screens/Profile_screen.dart';
import 'package:health_and_doctor_appointment/features/home/screens/homePage.dart';

import 'features/appointment/screens/appointment_Screen.dart';
import 'features/doctor/screens/doctorsList.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    DoctorsList(),
    MyAppointments(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        // Add margin to make it float
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
        decoration: BoxDecoration(
          color: Colors.white,
          // Rounded corners on all sides to look like a floating pill
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: 1,
              color: Colors.black.withOpacity(.15),
              offset:
                  const Offset(0, 10), // Moves shadow down for a "lifted" look
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          // Ensures ripple effects stay inside
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              curve: Curves.easeOutExpo,
              rippleColor: Colors.blue[100]!,
              // Softer ripple
              hoverColor: Colors.grey[100]!,
              haptic: true,
              tabBorderRadius: 20,
              gap: 8,
              activeColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              // Use a gradient or a solid blue for the selected tab
              tabBackgroundColor: Colors.blueAccent,
              textStyle: GoogleFonts.lato(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              tabs: const [
                GButton(icon: Icons.home_rounded, text: 'Home'),
                GButton(icon: Icons.search_rounded, text: 'Search'),
                GButton(icon: Icons.calendar_today_rounded, text: 'Schedule'),
                GButton(icon: Icons.person_rounded, text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
