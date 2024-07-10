import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/core/Router/go_route.dart';
import 'package:wallapp/core/utils/config/space.dart';
import 'package:wallapp/core/utils/config/app_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallapp/core/utils/constant/color_manger.dart';
import 'package:wallapp/core/utils/constant/image_assets.dart';
import 'package:wallapp/feature/on_barding_screen/widgets/custom_indicators.dart';
import 'package:wallapp/feature/on_barding_screen/logic/cubit/onboarding_cubit.dart';

class CustomBodyPage extends StatelessWidget {
  final String imagePath;
  final String titleText;
  final String subText;
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomBodyPage({
    Key? key,
    required this.imagePath,
    required this.titleText,
    required this.subText,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 2.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5), // Transparent black color
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalSpace(30),
                Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
                Text(
                  subText,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
                const CustomIndicators(),
                verticalSpace(20),
                if (onPressed != null)
                  Container(
                    decoration: const BoxDecoration(
                        color: ColorsManger.primaryColor,
                        shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(icon, color: Colors.white),
                      onPressed: onPressed,
                      color: Colors.orange,
                      iconSize: 48.0.h,
                    ),
                  ),
                verticalSpace(20),
                BlocListener<OnboardingCubit, OnboardingState>(
                  listener: (context, state) {
                    if (state is OnboardingSuccess) {
                      GoRouter.of(context).push(AppRouter.bottomNavigationBar);
                    }
                    if (state is OnboardingError) {
                      appLogger('Error signing in with Google');
                    }
                  },
                  child: BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<OnboardingCubit>(context)
                              .signInWithGoogle();
                        },
                        child: SizedBox(
                          height: 50.h,
                          width: 100.w,
                          child: Image.asset(ImageAssetsManger.google),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
