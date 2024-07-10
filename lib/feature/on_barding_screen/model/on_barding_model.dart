import 'package:wallapp/core/utils/constant/image_assets.dart';

class OnBardingModel {
  final String image;
  final String text;
  final String subText;
  OnBardingModel({
    required this.image,
    required this.text,
    required this.subText,
  });
}

List<OnBardingModel> onBarding = [
  OnBardingModel(
      image: ImageAssetsManger.on1,
      subText:
          'Get an overview of how you are performing and motivate yourself to achieve even more.',
      text: 'Track your mood'),
  OnBardingModel(
      image: ImageAssetsManger.on2,
      subText: 'Learn about the new features and how to use them.',
      text: 'Discover new features!'),
  OnBardingModel(
      image: ImageAssetsManger.on3,
      subText: 'Start using the app now and enjoy all its benefits.',
      text: 'Get Started!'),
];
