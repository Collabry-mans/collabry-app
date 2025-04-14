import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/on_boarding/model/on_boarding_model.dart';

//* Screens Routes
class Routes {
  //* onBoarding
  static const String onBoardingScreen = '/onBoardingScreen';

  //* Auth
  static const String logInScreen = '/logInScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String forgotPasswordVerificationScreen =
      '/forgotPasswordVerificationScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String signUpVerificationScreen = '/signUpVerificationScreen';

  //*main app screen
  static const String mainPageScreen = '/mainPageScreen';
  static const String createPublicationScreen = '/createPublicationScreen';
  static const String publicationByIdScreen = '/publicationByIdScreen';
}

//* Boxes Stuff
const String firstTimeBoxName = 'firstTimeBox';
const String kFirstTime = 'firstTimeBoxKey';
const String accessTokenKey = 'accessTokenKey';
const String refreshTokenKey = 'refreshTokenKey';

const String userBoxName = 'userBox';
const String kUserName = 'userName';
const String kUserEmail = 'userEmail';

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
