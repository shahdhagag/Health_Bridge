import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardModel {
  final String doctorType;
  final int cardBackground;
  final dynamic cardIcon; // Accept both IconData and FaIconData

  CardModel(this.doctorType, this.cardBackground, this.cardIcon);
}

final List<CardModel> cards = [
  CardModel("Dentist", 0xFF5c6bc0, FontAwesomeIcons.tooth),
  CardModel("Paediatrician", 0xFF2E7D32, FontAwesomeIcons.baby),
  CardModel("Eye Specialist", 0xFFfbc02d, FontAwesomeIcons.eye),
  CardModel("Cardiologist", 0xFFec407a, FontAwesomeIcons.heart),
  CardModel("Orthopaedic", 0xFF1565C0, FontAwesomeIcons.userInjured),
  CardModel("Neurologist", 0xFFEF6C00, FontAwesomeIcons.brain),
  CardModel("Dermatologist", 0xFFC51162, FontAwesomeIcons.handSparkles),
  CardModel("General Practitioner", 0xFF43A047, Icons.person),
  CardModel("Psychiatrist", 0xFF0097A7, FontAwesomeIcons.userDoctor), // userMd deprecated, use userDoctor
  CardModel("Gynecologist", 0xFFD50000, FontAwesomeIcons.venus),
  CardModel("ENT Specialist", 0xFF7E57C2, FontAwesomeIcons.earDeaf),
  CardModel("Urologist", 0xFF039BE5, Icons.person),
  CardModel("Oncologist", 0xFF6D4C41, FontAwesomeIcons.ribbon),
  CardModel("Pulmonologist", 0xFF00C853, FontAwesomeIcons.lungs),
  CardModel("Endocrinologist", 0xFFAA00FF, FontAwesomeIcons.droplet), // tint deprecated, use droplet
  CardModel("Gastroenterologist", 0xFFFF6F00, Icons.medical_services), // stomach not available, fallback
  CardModel("Nephrologist", 0xFF00E5FF, FontAwesomeIcons.droplet), // tint deprecated, use droplet
  CardModel("Rheumatologist", 0xFFA1887F, FontAwesomeIcons.userInjured),
  CardModel("Immunologist", 0xFF4CAF50, FontAwesomeIcons.shieldHalved), // shieldAlt deprecated, use shieldHalved
  CardModel("Hematologist", 0xFFD32F2F, FontAwesomeIcons.droplet), // tint deprecated, use droplet

];