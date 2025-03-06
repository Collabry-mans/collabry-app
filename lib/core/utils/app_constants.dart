import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/on_boarding/model/on_boarding_model.dart';

const String onBoardingScreen = '/';
const String logInScreen = 'logInScreen/';

List<OnBoardingModel> boardingScreens = [
  OnBoardingModel(
      image: Assets.imagesOnBoard1,
      text: AppStrings.onBoard1Txt,
      title: AppStrings.welcome),
  OnBoardingModel(
      image: Assets.imagesOnBoard2,
      text: AppStrings.onBoard2Txt,
      title: AppStrings.unlimitedCollaboration),
  OnBoardingModel(
      image: Assets.imagesOnBoard3,
      text: AppStrings.onBoard3Txt,
      title: AppStrings.powerOfAI),
  OnBoardingModel(
      image: Assets.imagesOnBoard4,
      text: AppStrings.onBoard4Txt,
      title: AppStrings.liveAndConnect),
];
