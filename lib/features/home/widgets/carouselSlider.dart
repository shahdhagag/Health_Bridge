import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/model/bannerModel.dart';
import 'package:health_and_doctor_appointment/features/disease/disease.dart';
import 'package:health_and_doctor_appointment/features/disease/diseasedetail.dart';

class Carouselslider extends StatelessWidget {
  const Carouselslider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: bannerCards.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const Disease()));
              } else if (index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const DiseaseDetail(disease: 'Covid-19')));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const DiseaseDetail(disease: 'General Health')));
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: bannerCards[index].cardBackground,
                ),
                boxShadow: [
                  BoxShadow(
                    color: bannerCards[index].cardBackground[0].withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Text Section
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bannerCards[index].text,
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Learn More",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Image Section
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        bannerCards[index].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 0.9,
          aspectRatio: 2.5,
        ),
      ),
    );
  }
}