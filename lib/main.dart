import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/features/auth/screens/Auth_Welcome_Screen.dart';
import 'package:health_and_doctor_appointment/mainPage.dart';
import 'package:health_and_doctor_appointment/features/onBoarding/OnBoarding.dart';
import 'package:health_and_doctor_appointment/features/user/screens/Profile_screen.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_and_doctor_appointment/shared/database_seeder.dart';
import 'package:health_and_doctor_appointment/shared/disease_seeder.dart';

import 'features/appointment/screens/appointment_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
 //DatabaseSeeder.seedDoctors();
 // await DiseaseSeeder.seedDiseases();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => user == null ?  Skip() : const MainPage(),
        '/login': (context) =>  AuthWelcomeScreen(),
        '/home': (context) => const MainPage(),
        '/profile': (context) =>  UserProfile(),
        '/MyAppointments': (context) => const MyAppointments(),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    );
  }
}