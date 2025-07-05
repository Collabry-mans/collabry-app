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
  static const String userProfileScreen = '/userProfileScreen';
}

//* keys
const String kTitle = 'title';
const String kContent = 'content';

//* Boxes Stuff
class HiveBoxes {
  static const String firstTimeBox = 'firstTimeBox';
  static const String userBox = 'userBox';
  static const String themeBox = 'themeBox';
}

class HiveKeys {
  static const String kFirstTime = 'firstTimeBoxKey';
  static const String kUserName = 'userName';
  static const String kUserEmail = 'userEmail';
  static const String kUserAvatar = 'userAvatar';
  static const String kTheme = 'theme';
}

const String accessTokenKey = 'accessTokenKey';
const String refreshTokenKey = 'refreshTokenKey';

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

List<String> categoriesList = ['AI', 'Barcelona', 'Nest.js', 'Electronics'];
List<String> statusList = ['Draft', 'Published'];
List<String> privacyList = ['Public', 'Private'];
