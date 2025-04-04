class EndPoints {
  static const String baseUrl = 'https://collabry.vercel.app/';
  static const String signUP = 'auth/register';
  static const String logIn = 'auth/login';
  static const String verificationEmail = 'auth/send-verification-email';
  static const String refreshToken = 'auth/refresh-token';
  static const String sendOtp = 'auth/send-otp';
  static const String verifyOtp = 'auth/verify-otp';
  static const String categories = 'categories';
  static const String publicationsCreate = 'publications/create';
}

class ApiKeys {
  //* Auth keys
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  static const String otp = 'otp';
  //* errors
  static const String message = 'message';
  static const String error = 'error';
  static const String statusCode = 'statusCode';
  //* category
  static const String id = 'id';
  static const String description = 'description';
  static const String parentId = 'parentId';
  static const String categoryId = 'categoryId';

  //* Publication
  static const String title = 'title';
  static const String keywords = 'keywords';
  static const String abstract = 'abstract';
  static const String language = 'language';
  static const String visibility = 'visibility';
}
