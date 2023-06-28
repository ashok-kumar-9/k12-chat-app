import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flutter/material.dart';

import '../../reusable_components/reusable_widgets.dart';
import 'onboarding_data.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = [
    AppColors.onBoarding1,
    AppColors.onBoarding2,
    AppColors.onBoarding3,
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        color: (_currentPage == index) ? Colors.blueAccent : Colors.white,
      ),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      curve: Curves.easeIn,
      width: (_currentPage == index) ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(contents[i].image),
                        const SizedBox(height: 16),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 30),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          contents[i].description,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (int index) => _buildDots(index: index),
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0)
                  .copyWith(bottom: 24),
              child: _currentPage + 1 == contents.length
                  ? ReusableWidgets().textButton(
                      function: () {
                        SharedPrefs().isOnBoardingDone = true;
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                      },
                      buttonText: "START",
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _pageController.jumpToPage(2);
                          },
                          style: TextButton.styleFrom(
                            elevation: 0,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          child: const Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ReusableWidgets().textButton(
                          function: () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                          buttonText: 'NEXT',
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
