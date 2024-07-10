import 'package:flutter/material.dart';
import '../logic/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../core/Router/go_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallapp/feature/splash_screen/widgets/sliding_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    BlocProvider.of<AuthCubit>(context).checkIfLoggedIn();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, bool>(
      listener: (context, isLoggedIn) {
        Future.delayed(
          const Duration(seconds: 2),
          () {
            if (isLoggedIn) {
              GoRouter.of(context)
                  .pushReplacement(AppRouter.bottomNavigationBar);
            } else {
              GoRouter.of(context).pushReplacement(AppRouter.onBardingScreen);
            }
          },
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/images/start.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Center(
              child: SlidingText(slidingAnimation: slidingAnimation),
            ),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }
}
