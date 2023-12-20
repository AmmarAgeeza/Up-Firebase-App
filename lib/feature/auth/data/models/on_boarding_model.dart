import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';

class OnBoardingModel {
  final String title;
  final String subTitle;
  final String imagePath;

  OnBoardingModel({
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  static List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
      title: AppStrings.onBoardingTitle1,
      subTitle: AppStrings.onBoardingSubTitle1,
      imagePath: AppAssets.onBoarding1,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle2,
      subTitle: AppStrings.onBoardingSubTitle2,
      imagePath: AppAssets.onBoarding2,
    ),
    OnBoardingModel(
      title: AppStrings.onBoardingTitle3,
      subTitle: AppStrings.onBoardingSubTitle3,
      imagePath: AppAssets.onBoarding3,
    ),
  ];
}
