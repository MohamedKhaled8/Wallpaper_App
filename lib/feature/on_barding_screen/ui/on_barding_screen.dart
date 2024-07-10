import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/feature/splash_screen/ui/splash_screen.dart';
import 'package:wallapp/feature/on_barding_screen/model/on_barding_model.dart';
import 'package:wallapp/feature/on_barding_screen/widgets/custom_body_page.dart';
import 'package:wallapp/feature/on_barding_screen/logic/cubit/onboarding_cubit.dart';

class OnBardingScreen extends StatelessWidget {
  const OnBardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller:
                  BlocProvider.of<OnboardingCubit>(context).pageController,
              onPageChanged: (index) {
                BlocProvider.of<OnboardingCubit>(context).changePage(index);
              },
              children: onBarding.map((model) {
                final isLastPage =
                    onBarding.indexOf(model) == onBarding.length - 1;
                return CustomBodyPage(
                  imagePath: model.image,
                  titleText: model.text,
                  subText: model.subText,
                  icon: isLastPage ? Icons.check : Icons.arrow_forward,
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashScreen()),
                      );
                    } else {
                      BlocProvider.of<OnboardingCubit>(context)
                          .pageController
                          .nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                    }
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
