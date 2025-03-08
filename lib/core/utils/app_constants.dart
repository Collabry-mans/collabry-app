import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/on_boarding/model/on_boarding_model.dart';

//* Screens Routes
const String onBoardingScreen = 'onBoardingScreen/';
const String logInScreen = 'logInScreen/';
const String forgotPasswordScreen = 'forgotPasswordScreen/';
const String forgotPasswordVerificationScreen =
    'forgotPasswordVerificationScreen/';
const String resetPasswordScreen = 'resetPasswordScreen/';
const String signUpScreen = 'signUpScreen/';
const String signUpVerificationScreen = 'signUpVerificationScreen/';

//* Boxes Stuff
const String firstTimeBoxName = 'firstTimeBox';
const String kFirstTime = 'firstTimeBoxKey';

//* Fonts
const String fontABeeZee = 'ABeeZee_button';
const String fontAllerta = 'Allerta_button';
const String fontBarlow = 'Barlow_header';
const String fontBelanosima = 'Belanosima_text';

//* Lists
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
