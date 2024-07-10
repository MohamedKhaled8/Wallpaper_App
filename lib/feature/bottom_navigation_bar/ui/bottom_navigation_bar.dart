import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_body_bottom_nav_bar.dart';
import '../logic/cubit/bottom_navigation_bar_cubit.dart';
import 'package:wallapp/feature/bottom_navigation_bar/widgets/custom_bottom_nav_bar.dart';

class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
      builder: (context, state) {
        return const Scaffold(
          body: CustomBodyBottomNavBar(),
          bottomNavigationBar: CustomBottomNavBar(),
        );
      },
    );
  }
}
