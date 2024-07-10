import 'package:flutter/widgets.dart';
import '../model/on_barding_model.dart';
import '../logic/cubit/onboarding_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/constant/color_manger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomIndicators extends StatelessWidget {
  const CustomIndicators({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        int currentPageIndex =
            state is OnboardingPageChanged ? state.pageIndex : 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onBarding.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.h),
              width: 12.w,
              height: 12.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == currentPageIndex
                    ? ColorsManger.primaryColor
                    : ColorsManger.gray,
              ),
            ),
          ),
        );
      },
    );
  }
}