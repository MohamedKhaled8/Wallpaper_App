part of 'setting_cubit.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}
class SettingIntervalUpdated extends SettingState {
  final Duration selectedDuration;
  SettingIntervalUpdated(this.selectedDuration);
}class SettingLocationUpdated extends SettingState {
  final int selectedLocation;

  SettingLocationUpdated(this.selectedLocation);
}class SettingAutoChangeWallpaperUpdated extends SettingState {
  final List<String> autoChangeWallpaperList;
  SettingAutoChangeWallpaperUpdated(this.autoChangeWallpaperList);
}