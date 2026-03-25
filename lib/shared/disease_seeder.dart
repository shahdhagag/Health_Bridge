import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseSeeder {
  static List<Map<String, dynamic>> diseaseData = [
    {
      "Name": "Influenza (Flu)",
      "Description": "A common viral infection that can be deadly, especially in high-risk groups.",
      "Spread": "By airborne respiratory droplets (coughs or sneezes).",
      "Symtomps": "Fever, chills, muscle aches, cough, congestion, and fatigue.",
      "Warning": "Difficulty breathing, chest pain, sudden dizziness, or severe vomiting."
    },
    {
      "Name": "Common Cold",
      "Description": "A viral infection of your nose and throat (upper respiratory tract).",
      "Spread": "Direct contact with infected people or surfaces.",
      "Symtomps": "Runny nose, sneezing, and sore throat.",
      "Warning": "Fever lasting more than 3 days or worsening symptoms."
    },
    {
      "Name": "Diabetes",
      "Description": "A group of diseases that result in too much sugar in the blood (high blood glucose).",
      "Spread": "Not contagious (Genetic or lifestyle factors).",
      "Symtomps": "Increased thirst, frequent urination, hunger, fatigue, and blurred vision.",
      "Warning": "Extreme thirst, confusion, or fruity-smelling breath (seek immediate care)."
    },
    {
      "Name": "Hypertension",
      "Description": "A condition in which the force of the blood against the artery walls is too high.",
      "Spread": "Not contagious (Lifestyle and genetic factors).",
      "Symtomps": "Often has no symptoms, but can cause headaches or shortness of breath.",
      "Warning": "Severe chest pain, severe headache, confusion, or blurred vision."
    },
    {
      "Name": "Asthma",
      "Description": "A condition in which your airways narrow and swell and may produce extra mucus.",
      "Spread": "Not contagious (Genetic and environmental factors).",
      "Symtomps": "Shortness of breath, chest tightness, wheezing, and coughing.",
      "Warning": "Severe shortness of breath, blue lips or face, or inability to speak."
    },
    {
      "Name": "COVID-19",
      "Description": "A respiratory illness caused by the coronavirus SARS-CoV-2.",
      "Spread": "By respiratory droplets, close contact, and contaminated surfaces.",
      "Symtomps": "Fever, cough, loss of taste or smell, fatigue, and difficulty breathing.",
      "Warning": "Trouble breathing, persistent pain or pressure in the chest, confusion."
    },
    {
      "Name": "Tuberculosis",
      "Description": "A potentially serious infectious disease that mainly affects the lungs.",
      "Spread": "Airborne droplets from coughs or sneezes of an infected person.",
      "Symtomps": "Cough (sometimes with blood), weight loss, night sweats, and fever.",
      "Warning": "Coughing up blood, severe chest pain, or difficulty breathing."
    },
    {
      "Name": "Chickenpox",
      "Description": "A highly contagious viral infection causing an itchy, blister-like rash.",
      "Spread": "Direct contact or airborne droplets from an infected person.",
      "Symtomps": "Itchy rash, fever, tiredness, and loss of appetite.",
      "Warning": "Rash spreading to eyes, trouble breathing, or persistent vomiting."
    },
    {
      "Name": "Measles",
      "Description": "A highly contagious viral disease marked by fever and a red rash.",
      "Spread": "Airborne droplets from coughs or sneezes of an infected person.",
      "Symtomps": "Fever, dry cough, runny nose, sore throat, and skin rash.",
      "Warning": "Difficulty breathing, persistent high fever, or seizures."
    },
    {
      "Name": "Malaria",
      "Description": "A disease caused by a plasmodium parasite, transmitted by the bite of infected mosquitoes.",
      "Spread": "By the bite of an infected Anopheles mosquito.",
      "Symtomps": "Fever, chills, headache, nausea, and muscle pain.",
      "Warning": "Severe anemia, respiratory distress, or organ failure."
    },
    {
      "Name": "Hepatitis B",
      "Description": "A serious liver infection caused by the hepatitis B virus (HBV).",
      "Spread": "Contact with infectious body fluids, such as blood.",
      "Symtomps": "Abdominal pain, dark urine, fever, joint pain, and jaundice.",
      "Warning": "Severe abdominal pain, confusion, or bleeding easily."
    },
    {
      "Name": "HIV/AIDS",
      "Description": "A virus that attacks the immune system and can lead to AIDS.",
      "Spread": "Unprotected sex, sharing needles, or from mother to child.",
      "Symtomps": "Fever, sore throat, fatigue, weight loss, and recurrent infections.",
      "Warning": "Severe infections, confusion, or rapid weight loss."
    },
    {
      "Name": "Dengue Fever",
      "Description": "A mosquito-borne viral disease occurring in tropical and subtropical areas.",
      "Spread": "By the bite of an infected Aedes mosquito.",
      "Symtomps": "High fever, headache, pain behind the eyes, joint and muscle pain, rash.",
      "Warning": "Severe abdominal pain, persistent vomiting, or bleeding."
    },
    {
      "Name": "Pneumonia",
      "Description": "Infection that inflames air sacs in one or both lungs, which may fill with fluid.",
      "Spread": "Airborne droplets, or by blood, especially in infants.",
      "Symtomps": "Cough with phlegm, fever, chills, and difficulty breathing.",
      "Warning": "Severe difficulty breathing, chest pain, or confusion."
    },
    {
      "Name": "Meningitis",
      "Description": "Inflammation of brain and spinal cord membranes, typically caused by an infection.",
      "Spread": "Airborne droplets, close contact, or sharing utensils.",
      "Symtomps": "Sudden high fever, stiff neck, headache, nausea, and sensitivity to light.",
      "Warning": "Seizures, confusion, or loss of consciousness."
    }
  ];
  static Future<void> seedDiseases() async {
    CollectionReference diseases =
    FirebaseFirestore.instance.collection('disease');

    for (var disease in diseaseData) {
      String name = disease["Name"];

      // safe document id (IMPORTANT)
      String docId = name
          .toLowerCase()
          .replaceAll(" ", "_")
          .replaceAll("/", "_");

      await diseases.doc(docId).set(disease);
    }

    print("✅ Disease data uploaded successfully!");
  }



}