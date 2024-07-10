part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingPageChanged extends OnboardingState {
  final int pageIndex;

  OnboardingPageChanged(this.pageIndex);
}
final class OnboardingSuccess extends OnboardingState {}
final class OnboardingError extends OnboardingState {}
