import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth/screens/Auth_Welcome_Screen.dart';

class Skip extends StatefulWidget {
  const Skip({Key? key}) : super(key: key);

  @override
  _SkipState createState() => _SkipState();
}

class _SkipState extends State<Skip> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Search Top\nSpecialists",
      "subtitle": "Connect with world-class doctors from the comfort of your home.",
      "image": "assets/onboard1.png",
    },
    {
      "title": "Smart Health\nInsights",
      "subtitle": "Identify symptoms and get detailed information about various conditions.",
      "image": "assets/onboard2.png",
    },
    {
      "title": "Instant\nBooking",
      "subtitle": "Skip the waiting room. Schedule your next visit in just a few taps.",
      "image": "assets/onboard2.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Animated Image Background
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Container(
              key: ValueKey<int>(_currentPage),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                image: DecorationImage(
                  image: AssetImage(_onboardingData[_currentPage]["image"]!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // 2. The Bottom Glass Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Indicator (Pills)
                    Row(
                      children: List.generate(
                        _onboardingData.length,
                            (index) => _buildIndicator(index == _currentPage),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Animated Text Content
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) => setState(() => _currentPage = value),
                        itemCount: _onboardingData.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _onboardingData[index]["title"]!,
                                style: GoogleFonts.lato(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.indigo[900],
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                _onboardingData[index]["subtitle"]!,
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    // Navigation Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => _finishOnboarding(),
                          child: Text(
                            "Skip",
                            style: GoogleFonts.lato(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        _buildNextButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 6,
      width: isActive ? 24 : 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo : Colors.indigo[100],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildNextButton() {
    bool isLastPage = _currentPage == _onboardingData.length - 1;
    return GestureDetector(
      onTap: () {
        if (isLastPage) {
          _finishOnboarding();
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 60,
        width: isLastPage ? 160 : 60,
        decoration: BoxDecoration(
          color: Colors.indigo[900],
          borderRadius: BorderRadius.circular(isLastPage ? 20 : 30),
        ),
        child: Center(
          child: isLastPage
              ? Text(
            "Get Started",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
              : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  void _finishOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) =>  AuthWelcomeScreen()),
    );
  }
}