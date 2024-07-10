part of 'bottom_navigation_bar_cubit.dart';

@immutable
sealed class BottomNavigationBarState {}

final class BottomNavigationBarInitial extends BottomNavigationBarState {}
class BottomNavigationBarUpdated extends BottomNavigationBarState {
  final int index;
  BottomNavigationBarUpdated(this.index);
}