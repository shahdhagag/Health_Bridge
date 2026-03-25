// TODO Implement this library.
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSeeder {
  static List<Map<String, dynamic>> doctorData = [
    // 6 Dentists
    {
      "name": "Dr. Alice Smith",
      "image": "https://randomuser.me/api/portraits/women/1.jpg",
      "type": "Dentist",
      "rating": 5,
      "specification": "Dental care and oral surgery.",
      "address": "101 Tooth Rd, MedCity",
      "phone": "1000000001",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Brian Lee",
      "image": "https://randomuser.me/api/portraits/men/2.jpg",
      "type": "Dentist",
      "rating": 4,
      "specification": "Expert in cosmetic dentistry.",
      "address": "102 Tooth Rd, MedCity",
      "phone": "1000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Clara Evans",
      "image": "https://randomuser.me/api/portraits/women/3.jpg",
      "type": "Dentist",
      "rating": 5,
      "specification": "Specialist in pediatric dentistry.",
      "address": "103 Tooth Rd, MedCity",
      "phone": "1000000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Daniel Kim",
      "image": "https://randomuser.me/api/portraits/men/4.jpg",
      "type": "Dentist",
      "rating": 4,
      "specification": "Orthodontics and braces expert.",
      "address": "104 Tooth Rd, MedCity",
      "phone": "1000000004",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Emily Brown",
      "image": "https://randomuser.me/api/portraits/women/5.jpg",
      "type": "Dentist",
      "rating": 5,
      "specification": "Implant and prosthodontics specialist.",
      "address": "105 Tooth Rd, MedCity",
      "phone": "1000000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Frank Green",
      "image": "https://randomuser.me/api/portraits/men/6.jpg",
      "type": "Dentist",
      "rating": 3,
      "specification": "General dental practitioner.",
      "address": "106 Tooth Rd, MedCity",
      "phone": "1000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Paediatricians
    {
      "name": "Dr. Grace White",
      "image": "https://randomuser.me/api/portraits/women/7.jpg",
      "type": "Paediatrician",
      "rating": 5,
      "specification": "Child health and wellness expert.",
      "address": "201 Kids Rd, MedCity",
      "phone": "2000000001",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Henry Black",
      "image": "https://randomuser.me/api/portraits/men/8.jpg",
      "type": "Paediatrician",
      "rating": 4,
      "specification": "Specialist in childhood immunizations.",
      "address": "202 Kids Rd, MedCity",
      "phone": "2000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Irene King",
      "image": "https://randomuser.me/api/portraits/women/9.jpg",
      "type": "Paediatrician",
      "rating": 5,
      "specification": "Neonatal and infant care specialist.",
      "address": "203 Kids Rd, MedCity",
      "phone": "2000000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Jack Young",
      "image": "https://randomuser.me/api/portraits/men/10.jpg",
      "type": "Paediatrician",
      "rating": 4,
      "specification": "Adolescent medicine expert.",
      "address": "204 Kids Rd, MedCity",
      "phone": "2000000004",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Karen Scott",
      "image": "https://randomuser.me/api/portraits/women/11.jpg",
      "type": "Paediatrician",
      "rating": 5,
      "specification": "Pediatric allergy specialist.",
      "address": "205 Kids Rd, MedCity",
      "phone": "2000000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Leo Adams",
      "image": "https://randomuser.me/api/portraits/men/12.jpg",
      "type": "Paediatrician",
      "rating": 3,
      "specification": "General pediatric practitioner.",
      "address": "206 Kids Rd, MedCity",
      "phone": "2000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Cardiologists
    {
      "name": "Dr. Mia Clark",
      "image": "https://randomuser.me/api/portraits/women/13.jpg",
      "type": "Cardiologist",
      "rating": 5,
      "specification": "Expert in heart diseases and treatments.",
      "address": "301 Heart Ave, MedCity",
      "phone": "3000000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Nick Evans",
      "image": "https://randomuser.me/api/portraits/men/14.jpg",
      "type": "Cardiologist",
      "rating": 4,
      "specification": "Specialist in interventional cardiology.",
      "address": "302 Heart Ave, MedCity",
      "phone": "3000000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Olivia Harris",
      "image": "https://randomuser.me/api/portraits/women/15.jpg",
      "type": "Cardiologist",
      "rating": 5,
      "specification": "Heart failure and transplant specialist.",
      "address": "303 Heart Ave, MedCity",
      "phone": "3000000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Paul Turner",
      "image": "https://randomuser.me/api/portraits/men/16.jpg",
      "type": "Cardiologist",
      "rating": 3,
      "specification": "General cardiology and preventive care.",
      "address": "304 Heart Ave, MedCity",
      "phone": "3000000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Quinn Walker",
      "image": "https://randomuser.me/api/portraits/men/17.jpg",
      "type": "Cardiologist",
      "rating": 4,
      "specification": "Electrophysiology and arrhythmia specialist.",
      "address": "305 Heart Ave, MedCity",
      "phone": "3000000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Rose Martinez",
      "image": "https://randomuser.me/api/portraits/women/18.jpg",
      "type": "Cardiologist",
      "rating": 5,
      "specification": "Cardiac imaging and diagnostics expert.",
      "address": "306 Heart Ave, MedCity",
      "phone": "3000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Dermatologists
    {
      "name": "Dr. Steve Lewis",
      "image": "https://randomuser.me/api/portraits/men/19.jpg",
      "type": "Dermatologist",
      "rating": 4,
      "specification": "Specialist in skin conditions and cosmetic procedures.",
      "address": "401 Skin St, MedCity",
      "phone": "4000000001",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Tina Perez",
      "image": "https://randomuser.me/api/portraits/women/20.jpg",
      "type": "Dermatologist",
      "rating": 5,
      "specification": "Expert in laser surgery and skin rejuvenation.",
      "address": "402 Skin St, MedCity",
      "phone": "4000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Uma Patel",
      "image": "https://randomuser.me/api/portraits/women/21.jpg",
      "type": "Dermatologist",
      "rating": 4,
      "specification": "Pediatric dermatology specialist.",
      "address": "403 Skin St, MedCity",
      "phone": "4000000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Victor Hugo",
      "image": "https://randomuser.me/api/portraits/men/22.jpg",
      "type": "Dermatologist",
      "rating": 5,
      "specification": "Dermatopathology and skin cancer expert.",
      "address": "404 Skin St, MedCity",
      "phone": "4000000004",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Wendy Chang",
      "image": "https://randomuser.me/api/portraits/women/23.jpg",
      "type": "Dermatologist",
      "rating": 3,
      "specification": "General dermatology and skin care.",
      "address": "405 Skin St, MedCity",
      "phone": "4000000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Xander Cage",
      "image": "https://randomuser.me/api/portraits/men/24.jpg",
      "type": "Dermatologist",
      "rating": 4,
      "specification": "Cosmetic dermatology and anti-aging treatments.",
      "address": "406 Skin St, MedCity",
      "phone": "4000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Orthopedic Surgeons
    {
      "name": "Dr. Alice Wonderland",
      "image": "https://randomuser.me/api/portraits/women/25.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 5,
      "specification": "Bone and joint surgery specialist.",
      "address": "501 Bone Blvd, MedCity",
      "phone": "5000000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Bob Builder",
      "image": "https://randomuser.me/api/portraits/men/26.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 4,
      "specification": "Expert in sports injuries and rehabilitation.",
      "address": "502 Bone Blvd, MedCity",
      "phone": "5000000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Carol Singer",
      "image": "https://randomuser.me/api/portraits/women/27.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 5,
      "specification": "Knee and hip replacement specialist.",
      "address": "503 Bone Blvd, MedCity",
      "phone": "5000000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. David Copperfield",
      "image": "https://randomuser.me/api/portraits/men/28.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 3,
      "specification": "General orthopedic surgery.",
      "address": "504 Bone Blvd, MedCity",
      "phone": "5000000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Eva Green",
      "image": "https://randomuser.me/api/portraits/women/29.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 4,
      "specification": "Shoulder and elbow surgery specialist.",
      "address": "505 Bone Blvd, MedCity",
      "phone": "5000000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Frank Sinatra",
      "image": "https://randomuser.me/api/portraits/men/30.jpg",
      "type": "Orthopedic Surgeon",
      "rating": 5,
      "specification": "Foot and ankle surgery expert.",
      "address": "506 Bone Blvd, MedCity",
      "phone": "5000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Neurologists
    {
      "name": "Dr. Grace Hopper",
      "image": "https://randomuser.me/api/portraits/women/31.jpg",
      "type": "Neurologist",
      "rating": 5,
      "specification": "Brain and nervous system disorders.",
      "address": "601 Brain Ln, MedCity",
      "phone": "6000000001",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Henry Ford",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
      "type": "Neurologist",
      "rating": 4,
      "specification": "Specialist in stroke and cerebrovascular disorders.",
      "address": "602 Brain Ln, MedCity",
      "phone": "6000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Irene Adler",
      "image": "https://randomuser.me/api/portraits/women/33.jpg",
      "type": "Neurologist",
      "rating": 5,
      "specification": "Expert in epilepsy and seizure disorders.",
      "address": "603 Brain Ln, MedCity",
      "phone": "6000000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Jack Daniels",
      "image": "https://randomuser.me/api/portraits/men/34.jpg",
      "type": "Neurologist",
      "rating": 3,
      "specification": "General neurology and headache disorders.",
      "address": "604 Brain Ln, MedCity",
      "phone": "6000000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Karen Blixen",
      "image": "https://randomuser.me/api/portraits/women/35.jpg",
      "type": "Neurologist",
      "rating": 4,
      "specification": "Multiple sclerosis and neuroimmunology expert.",
      "address": "605 Brain Ln, MedCity",
      "phone": "6000000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Leo Tolstoy",
      "image": "https://randomuser.me/api/portraits/men/36.jpg",
      "type": "Neurologist",
      "rating": 5,
      "specification": "Neurodegenerative diseases and dementia specialist.",
      "address": "606 Brain Ln, MedCity",
      "phone": "6000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 General Practitioners
    {
      "name": "Dr. Alice Walker",
      "image": "https://randomuser.me/api/portraits/women/37.jpg",
      "type": "General Practitioner",
      "rating": 5,
      "specification": "Primary care and general health.",
      "address": "701 Health St, MedCity",
      "phone": "7000000001",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Bob Marley",
      "image": "https://randomuser.me/api/portraits/men/38.jpg",
      "type": "General Practitioner",
      "rating": 4,
      "specification": "Family medicine and chronic disease management.",
      "address": "702 Health St, MedCity",
      "phone": "7000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Clara Zetkin",
      "image": "https://randomuser.me/api/portraits/women/39.jpg",
      "type": "General Practitioner",
      "rating": 5,
      "specification": "Women's health and preventive care.",
      "address": "703 Health St, MedCity",
      "phone": "7000000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Daniel Defoe",
      "image": "https://randomuser.me/api/portraits/men/40.jpg",
      "type": "General Practitioner",
      "rating": 3,
      "specification": "Men's health and wellness.",
      "address": "704 Health St, MedCity",
      "phone": "7000000004",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Emily Dickinson",
      "image": "https://randomuser.me/api/portraits/women/41.jpg",
      "type": "General Practitioner",
      "rating": 4,
      "specification": "Geriatric care and chronic illness management.",
      "address": "705 Health St, MedCity",
      "phone": "7000000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Frank Lloyd Wright",
      "image": "https://randomuser.me/api/portraits/men/42.jpg",
      "type": "General Practitioner",
      "rating": 5,
      "specification": "Acute care and minor surgical procedures.",
      "address": "706 Health St, MedCity",
      "phone": "7000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Gynecologists
    {
      "name": "Dr. Grace Kelly",
      "image": "https://randomuser.me/api/portraits/women/43.jpg",
      "type": "Gynecologist",
      "rating": 5,
      "specification": "Women's health and pregnancy care.",
      "address": "801 Women Ave, MedCity",
      "phone": "8000000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Henry VIII",
      "image": "https://randomuser.me/api/portraits/men/44.jpg",
      "type": "Gynecologist",
      "rating": 4,
      "specification": "Reproductive endocrinology and infertility specialist.",
      "address": "802 Women Ave, MedCity",
      "phone": "8000000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Irene Joliot-Curie",
      "image": "https://randomuser.me/api/portraits/women/45.jpg",
      "type": "Gynecologist",
      "rating": 5,
      "specification": "Gynecologic oncology and minimally invasive surgery.",
      "address": "803 Women Ave, MedCity",
      "phone": "8000000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Jack the Ripper",
      "image": "https://randomuser.me/api/portraits/men/46.jpg",
      "type": "Gynecologist",
      "rating": 3,
      "specification": "General gynecology and obstetrics.",
      "address": "804 Women Ave, MedCity",
      "phone": "8000000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Karen Carpenter",
      "image": "https://randomuser.me/api/portraits/women/47.jpg",
      "type": "Gynecologist",
      "rating": 4,
      "specification": "Menopause and hormone replacement therapy.",
      "address": "805 Women Ave, MedCity",
      "phone": "8000000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Leo Messi",
      "image": "https://randomuser.me/api/portraits/men/48.jpg",
      "type": "Gynecologist",
      "rating": 5,
      "specification": "Pelvic floor disorders and reconstructive surgery.",
      "address": "806 Women Ave, MedCity",
      "phone": "8000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Ophthalmologists
    {
      "name": "Dr. Mia Farrow",
      "image": "https://randomuser.me/api/portraits/women/49.jpg",
      "type": "Ophthalmologist",
      "rating": 5,
      "specification": "Eye care and vision correction.",
      "address": "901 Eye St, MedCity",
      "phone": "9000000001",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Nick Fury",
      "image": "https://randomuser.me/api/portraits/men/50.jpg",
      "type": "Ophthalmologist",
      "rating": 4,
      "specification": "Specialist in cataract and glaucoma surgery.",
      "address": "902 Eye St, MedCity",
      "phone": "9000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Olivia Newton-John",
      "image": "https://randomuser.me/api/portraits/women/51.jpg",
      "type": "Ophthalmologist",
      "rating": 5,
      "specification": "Pediatric ophthalmology and strabismus specialist.",
      "address": "903 Eye St, MedCity",
      "phone": "9000000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Paul McCartney",
      "image": "https://randomuser.me/api/portraits/men/52.jpg",
      "type": "Ophthalmologist",
      "rating": 3,
      "specification": "Comprehensive eye care and contact lens fitting.",
      "address": "904 Eye St, MedCity",
      "phone": "9000000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Queen Latifah",
      "image": "https://randomuser.me/api/portraits/women/53.jpg",
      "type": "Ophthalmologist",
      "rating": 4,
      "specification": "Corneal surgery and refractive surgery expert.",
      "address": "905 Eye St, MedCity",
      "phone": "9000000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Robert Downey Jr.",
      "image": "https://randomuser.me/api/portraits/men/54.jpg",
      "type": "Ophthalmologist",
      "rating": 5,
      "specification": "Oculoplastic surgery and orbital disorders specialist.",
      "address": "906 Eye St, MedCity",
      "phone": "9000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Urologists
    {
      "name": "Dr. Alice Cooper",
      "image": "https://randomuser.me/api/portraits/women/55.jpg",
      "type": "Urologist",
      "rating": 5,
      "specification": "Urinary tract and male health.",
      "address": "1001 Uro Rd, MedCity",
      "phone": "1000000001",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Brian May",
      "image": "https://randomuser.me/api/portraits/men/56.jpg",
      "type": "Urologist",
      "rating": 4,
      "specification": "Expert in male infertility and erectile dysfunction.",
      "address": "1002 Uro Rd, MedCity",
      "phone": "1000000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Clara Oswald",
      "image": "https://randomuser.me/api/portraits/women/57.jpg",
      "type": "Urologist",
      "rating": 5,
      "specification": "Pediatric urology and bladder disorders.",
      "address": "1003 Uro Rd, MedCity",
      "phone": "1000000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Daniel Radcliffe",
      "image": "https://randomuser.me/api/portraits/men/58.jpg",
      "type": "Urologist",
      "rating": 4,
      "specification": "Urologic oncology and robotic surgery.",
      "address": "1004 Uro Rd, MedCity",
      "phone": "1000000004",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Emily Blunt",
      "image": "https://randomuser.me/api/portraits/women/59.jpg",
      "type": "Urologist",
      "rating": 3,
      "specification": "General urology and stone disease.",
      "address": "1005 Uro Rd, MedCity",
      "phone": "1000000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Frank Underwood",
      "image": "https://randomuser.me/api/portraits/men/60.jpg",
      "type": "Urologist",
      "rating": 5,
      "specification": "Male sexual health and hormone therapy.",
      "address": "1006 Uro Rd, MedCity",
      "phone": "1000000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Oncologists
    {
      "name": "Dr. Grace Jones",
      "image": "https://randomuser.me/api/portraits/women/61.jpg",
      "type": "Oncologist",
      "rating": 5,
      "specification": "Cancer diagnosis and treatment.",
      "address": "1101 Cancer Ave, MedCity",
      "phone": "1100000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Henry Cavill",
      "image": "https://randomuser.me/api/portraits/men/62.jpg",
      "type": "Oncologist",
      "rating": 4,
      "specification": "Expert in chemotherapy and radiation therapy.",
      "address": "1102 Cancer Ave, MedCity",
      "phone": "1100000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Irene Adler",
      "image": "https://randomuser.me/api/portraits/women/63.jpg",
      "type": "Oncologist",
      "rating": 5,
      "specification": "Surgical oncology and tumor board member.",
      "address": "1103 Cancer Ave, MedCity",
      "phone": "1100000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Jack Sparrow",
      "image": "https://randomuser.me/api/portraits/men/64.jpg",
      "type": "Oncologist",
      "rating": 3,
      "specification": "General oncology and palliative care.",
      "address": "1104 Cancer Ave, MedCity",
      "phone": "1100000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Karen Gillan",
      "image": "https://randomuser.me/api/portraits/women/65.jpg",
      "type": "Oncologist",
      "rating": 4,
      "specification": "Breast cancer and hereditary cancer syndromes.",
      "address": "1105 Cancer Ave, MedCity",
      "phone": "1100000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Leo DiCaprio",
      "image": "https://randomuser.me/api/portraits/men/66.jpg",
      "type": "Oncologist",
      "rating": 5,
      "specification": "Lung cancer and mesothelioma specialist.",
      "address": "1106 Cancer Ave, MedCity",
      "phone": "1100000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Pulmonologists
    {
      "name": "Dr. Alice in Wonderland",
      "image": "https://randomuser.me/api/portraits/women/67.jpg",
      "type": "Pulmonologist",
      "rating": 5,
      "specification": "Lung and respiratory care.",
      "address": "1201 Lung St, MedCity",
      "phone": "1200000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Brian Cranston",
      "image": "https://randomuser.me/api/portraits/men/68.jpg",
      "type": "Pulmonologist",
      "rating": 4,
      "specification": "Sleep medicine and pulmonary rehabilitation.",
      "address": "1202 Lung St, MedCity",
      "phone": "1200000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Clara Peller",
      "image": "https://randomuser.me/api/portraits/women/69.jpg",
      "type": "Pulmonologist",
      "rating": 5,
      "specification": "Interstitial lung disease and sarcoidosis specialist.",
      "address": "1203 Lung St, MedCity",
      "phone": "1200000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Daniel Day-Lewis",
      "image": "https://randomuser.me/api/portraits/men/70.jpg",
      "type": "Pulmonologist",
      "rating": 3,
      "specification": "General pulmonology and critical care.",
      "address": "1204 Lung St, MedCity",
      "phone": "1200000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Emily Blunt",
      "image": "https://randomuser.me/api/portraits/women/71.jpg",
      "type": "Pulmonologist",
      "rating": 4,
      "specification": "COPD and asthma management specialist.",
      "address": "1205 Lung St, MedCity",
      "phone": "1200000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Frank Zappa",
      "image": "https://randomuser.me/api/portraits/men/72.jpg",
      "type": "Pulmonologist",
      "rating": 5,
      "specification": "Lung cancer and smoking cessation expert.",
      "address": "1206 Lung St, MedCity",
      "phone": "1200000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Endocrinologists
    {
      "name": "Dr. Grace Slick",
      "image": "https://randomuser.me/api/portraits/women/73.jpg",
      "type": "Endocrinologist",
      "rating": 5,
      "specification": "Hormone and metabolism specialist.",
      "address": "1301 Endo Rd, MedCity",
      "phone": "1300000001",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Henry Kissinger",
      "image": "https://randomuser.me/api/portraits/men/74.jpg",
      "type": "Endocrinologist",
      "rating": 4,
      "specification": "Diabetes and thyroid disorders specialist.",
      "address": "1302 Endo Rd, MedCity",
      "phone": "1300000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Irene Papas",
      "image": "https://randomuser.me/api/portraits/women/75.jpg",
      "type": "Endocrinologist",
      "rating": 5,
      "specification": "Adrenal and pituitary disorders expert.",
      "address": "1303 Endo Rd, MedCity",
      "phone": "1300000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Jack Nicholson",
      "image": "https://randomuser.me/api/portraits/men/76.jpg",
      "type": "Endocrinologist",
      "rating": 3,
      "specification": "General endocrinology and metabolic disorders.",
      "address": "1304 Endo Rd, MedCity",
      "phone": "1300000004",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Karen O'Connor",
      "image": "https://randomuser.me/api/portraits/women/77.jpg",
      "type": "Endocrinologist",
      "rating": 4,
      "specification": "Menopause and osteoporosis specialist.",
      "address": "1305 Endo Rd, MedCity",
      "phone": "1300000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Leo Messi",
      "image": "https://randomuser.me/api/portraits/men/78.jpg",
      "type": "Endocrinologist",
      "rating": 5,
      "specification": "Reproductive endocrinology and infertility specialist.",
      "address": "1306 Endo Rd, MedCity",
      "phone": "1300000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Gastroenterologists
    {
      "name": "Dr. Alice Cooper",
      "image": "https://randomuser.me/api/portraits/women/79.jpg",
      "type": "Gastroenterologist",
      "rating": 5,
      "specification": "Digestive system disorders.",
      "address": "1401 Gastro Ave, MedCity",
      "phone": "1400000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Brian Cox",
      "image": "https://randomuser.me/api/portraits/men/80.jpg",
      "type": "Gastroenterologist",
      "rating": 4,
      "specification": "Expert in endoscopy and colonoscopy.",
      "address": "1402 Gastro Ave, MedCity",
      "phone": "1400000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Clara Zetkin",
      "image": "https://randomuser.me/api/portraits/women/81.jpg",
      "type": "Gastroenterologist",
      "rating": 5,
      "specification": "Hepatology and liver disease specialist.",
      "address": "1403 Gastro Ave, MedCity",
      "phone": "1400000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Daniel Craig",
      "image": "https://randomuser.me/api/portraits/men/82.jpg",
      "type": "Gastroenterologist",
      "rating": 3,
      "specification": "General gastroenterology and nutrition.",
      "address": "1404 Gastro Ave, MedCity",
      "phone": "1400000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Emily Blunt",
      "image": "https://randomuser.me/api/portraits/women/83.jpg",
      "type": "Gastroenterologist",
      "rating": 4,
      "specification": "Inflammatory bowel disease and celiac disease specialist.",
      "address": "1405 Gastro Ave, MedCity",
      "phone": "1400000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Frank Sinatra",
      "image": "https://randomuser.me/api/portraits/men/84.jpg",
      "type": "Gastroenterologist",
      "rating": 5,
      "specification": "Pancreatic disease and biliary disorders specialist.",
      "address": "1406 Gastro Ave, MedCity",
      "phone": "1400000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Nephrologists
    {
      "name": "Dr. Grace Kelly",
      "image": "https://randomuser.me/api/portraits/women/85.jpg",
      "type": "Nephrologist",
      "rating": 5,
      "specification": "Kidney care and dialysis.",
      "address": "1501 Kidney St, MedCity",
      "phone": "1500000001",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Henry Ford",
      "image": "https://randomuser.me/api/portraits/men/86.jpg",
      "type": "Nephrologist",
      "rating": 4,
      "specification": "Hypertension and kidney disease specialist.",
      "address": "1502 Kidney St, MedCity",
      "phone": "1500000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Irene Adler",
      "image": "https://randomuser.me/api/portraits/women/87.jpg",
      "type": "Nephrologist",
      "rating": 5,
      "specification": "Glomerular diseases and nephrotic syndrome specialist.",
      "address": "1503 Kidney St, MedCity",
      "phone": "1500000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Jack Daniels",
      "image": "https://randomuser.me/api/portraits/men/88.jpg",
      "type": "Nephrologist",
      "rating": 3,
      "specification": "General nephrology and kidney transplantation.",
      "address": "1504 Kidney St, MedCity",
      "phone": "1500000004",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Karen Blixen",
      "image": "https://randomuser.me/api/portraits/women/89.jpg",
      "type": "Nephrologist",
      "rating": 4,
      "specification": "Polycystic kidney disease and renal artery stenosis specialist.",
      "address": "1505 Kidney St, MedCity",
      "phone": "1500000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Leo Tolstoy",
      "image": "https://randomuser.me/api/portraits/men/90.jpg",
      "type": "Nephrologist",
      "rating": 5,
      "specification": "End-stage renal disease and dialysis access specialist.",
      "address": "1506 Kidney St, MedCity",
      "phone": "1500000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Rheumatologists
    {
      "name": "Dr. Mia Farrow",
      "image": "https://randomuser.me/api/portraits/women/91.jpg",
      "type": "Rheumatologist",
      "rating": 5,
      "specification": "Arthritis and autoimmune diseases.",
      "address": "1601 Joint Ave, MedCity",
      "phone": "1600000001",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Nick Nolte",
      "image": "https://randomuser.me/api/portraits/men/92.jpg",
      "type": "Rheumatologist",
      "rating": 4,
      "specification": "Lupus and inflammatory arthritis specialist.",
      "address": "1602 Joint Ave, MedCity",
      "phone": "1600000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Olivia Wilde",
      "image": "https://randomuser.me/api/portraits/women/93.jpg",
      "type": "Rheumatologist",
      "rating": 5,
      "specification": "Gout and crystal arthropathies specialist.",
      "address": "1603 Joint Ave, MedCity",
      "phone": "1600000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Paul Rudd",
      "image": "https://randomuser.me/api/portraits/men/94.jpg",
      "type": "Rheumatologist",
      "rating": 3,
      "specification": "General rheumatology and musculoskeletal disorders.",
      "address": "1604 Joint Ave, MedCity",
      "phone": "1600000004",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Queen Elizabeth",
      "image": "https://randomuser.me/api/portraits/women/95.jpg",
      "type": "Rheumatologist",
      "rating": 4,
      "specification": "Scleroderma and vasculitis specialist.",
      "address": "1605 Joint Ave, MedCity",
      "phone": "1600000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Robert Plant",
      "image": "https://randomuser.me/api/portraits/men/96.jpg",
      "type": "Rheumatologist",
      "rating": 5,
      "specification": "Osteoporosis and metabolic bone disease specialist.",
      "address": "1606 Joint Ave, MedCity",
      "phone": "1600000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Immunologists
    {
      "name": "Dr. Alice Walker",
      "image": "https://randomuser.me/api/portraits/women/97.jpg",
      "type": "Immunologist",
      "rating": 5,
      "specification": "Immune system disorders.",
      "address": "1701 Immune Rd, MedCity",
      "phone": "1700000001",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Bob Marley",
      "image": "https://randomuser.me/api/portraits/men/98.jpg",
      "type": "Immunologist",
      "rating": 4,
      "specification": "Allergies and asthma specialist.",
      "address": "1702 Immune Rd, MedCity",
      "phone": "1700000002",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Clara Zetkin",
      "image": "https://randomuser.me/api/portraits/women/99.jpg",
      "type": "Immunologist",
      "rating": 5,
      "specification": "Immunodeficiency and HIV specialist.",
      "address": "1703 Immune Rd, MedCity",
      "phone": "1700000003",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Daniel Craig",
      "image": "https://randomuser.me/api/portraits/men/100.jpg",
      "type": "Immunologist",
      "rating": 3,
      "specification": "General immunology and vaccine preventable diseases.",
      "address": "1704 Immune Rd, MedCity",
      "phone": "1700000004",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Emily Blunt",
      "image": "https://randomuser.me/api/portraits/women/101.jpg",
      "type": "Immunologist",
      "rating": 4,
      "specification": "Autoimmune diseases and immunotherapy.",
      "address": "1705 Immune Rd, MedCity",
      "phone": "1700000005",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Frank Zappa",
      "image": "https://randomuser.me/api/portraits/men/102.jpg",
      "type": "Immunologist",
      "rating": 5,
      "specification": "Transplant immunology and tolerance induction.",
      "address": "1706 Immune Rd, MedCity",
      "phone": "1700000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    // 6 Hematologists
    {
      "name": "Dr. Grace Hopper",
      "image": "https://randomuser.me/api/portraits/women/103.jpg",
      "type": "Hematologist",
      "rating": 5,
      "specification": "Blood diseases and treatments.",
      "address": "1801 Blood St, MedCity",
      "phone": "1800000001",
      "openHour": "08:00",
      "closeHour": "16:00"
    },
    {
      "name": "Dr. Henry VIII",
      "image": "https://randomuser.me/api/portraits/men/104.jpg",
      "type": "Hematologist",
      "rating": 4,
      "specification": "Coagulation disorders and hemophilia specialist.",
      "address": "1802 Blood St, MedCity",
      "phone": "1800000002",
      "openHour": "09:00",
      "closeHour": "17:00"
    },
    {
      "name": "Dr. Irene Curie",
      "image": "https://randomuser.me/api/portraits/women/105.jpg",
      "type": "Hematologist",
      "rating": 5,
      "specification": "Sickle cell disease and thalassemia specialist.",
      "address": "1803 Blood St, MedCity",
      "phone": "1800000003",
      "openHour": "10:00",
      "closeHour": "18:00"
    },
    {
      "name": "Dr. Jack Daniels",
      "image": "https://randomuser.me/api/portraits/men/106.jpg",
      "type": "Hematologist",
      "rating": 3,
      "specification": "General hematology and blood bank.",
      "address": "1804 Blood St, MedCity",
      "phone": "1800000004",
      "openHour": "08:30",
      "closeHour": "16:30"
    },
    {
      "name": "Dr. Karen Blixen",
      "image": "https://randomuser.me/api/portraits/women/107.jpg",
      "type": "Hematologist",
      "rating": 4,
      "specification": "Bone marrow disorders and stem cell transplantation.",
      "address": "1805 Blood St, MedCity",
      "phone": "1800000005",
      "openHour": "09:30",
      "closeHour": "17:30"
    },
    {
      "name": "Dr. Leo Messi",
      "image": "https://randomuser.me/api/portraits/men/108.jpg",
      "type": "Hematologist",
      "rating": 5,
      "specification": "Lymphoma and leukemia specialist.",
      "address": "1806 Blood St, MedCity",
      "phone": "1800000006",
      "openHour": "10:00",
      "closeHour": "18:00"
    }


    // ... add the rest of the doctors from your list here
  ];

  static Future<void> seedDoctors() async {
    CollectionReference doctors = FirebaseFirestore.instance.collection('doctors');

    for (var doctor in doctorData) {
      await doctors.add(doctor);
    }
    print("✅ All doctors added successfully!");
  }
}