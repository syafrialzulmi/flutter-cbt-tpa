import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_indicator.dart';
import '../../../core/components/buttons.dart';
import '../../../core/assets/assets.gen.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../auth/pages/login_page.dart';
import '../../../data/datasources/onboarding_local_datasource.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  final pageController = PageController();

  final onboardingData = [
    OnboardingModel(
      image: Assets.images.onboarding.screen1.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
    OnboardingModel(
      image: Assets.images.onboarding.screen2.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
    OnboardingModel(
      image: Assets.images.onboarding.screen3.path,
      text: 'Jelajahi Potensimu dengan Tes Online Akademik di CWB !',
    ),
  ];

  void navigate() {
    context.pushReplacement(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.onboarding.ornament.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            OnboardingContent(
              pageController: pageController,
              onPageChanged: (index) {
                currentPage = index;
                setState(() {});
              },
              contents: onboardingData,
            ),
            OnboardingIndicator(
              length: onboardingData.length,
              currentPage: currentPage,
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Button.filled(
                onPressed: () {
                  if (currentPage < onboardingData.length - 1) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                    currentPage++;
                    setState(() {});
                  } else {
                    OnboardingLocalDatasource().saveOnboadingPassed();
                    navigate();
                  }
                },
                label: 'Continue',
              ),
            ),
          ],
        )
      ],
    ));
  }
}
