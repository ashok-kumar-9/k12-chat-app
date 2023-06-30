import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/services/shared_prefs.dart';
import 'package:flash_chat/utils/constants.dart';
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
        borderRadius: const BorderRadius.all(
            Radius.circular(RadiusConstants.dotIndicatorRadius)),
        color: (_currentPage == index) ? Colors.blueAccent : Colors.white,
      ),
      margin: const EdgeInsets.only(right: PaddingConstants.padding1),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingConstants.padding2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(contents[i].image),
                        const SizedBox(height: SpacerConstant.spacer2),
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .h1
                              .copyWith(color: AppColors.black),
                        ),
                        const SizedBox(height: SpacerConstant.spacer2),
                        Text(
                          contents[i].description,
                          style: Theme.of(context)
                              .textTheme
                              .h4
                              .copyWith(color: AppColors.black),
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
            const SizedBox(height: SpacerConstant.spacer2),
            Padding(
              padding: const EdgeInsets.all(PaddingConstants.padding3)
                  .copyWith(top: 0),
              child: _currentPage + 1 == contents.length
                  ? ReusableWidgets().customButton(
                      onTap: () {
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
                              textStyle: Theme.of(context).textTheme.h5),
                          child: const Text(
                            "SKIP",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ReusableWidgets().customButton(
                          onTap: () {
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
