class EndPoints {
  static const String baseUrl = 'https://collabry.vercel.app/';
  static const String signUP = 'auth/register';
  static const String logIn = 'auth/login';
  static const String verificationEmail = 'auth/send-verification-email';
  static const String refreshToken = 'auth/refresh-token';
}

class ApiKeys {
  //* sign up keys
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String accessToken = 'accessToken';
  static const String refreshToken = 'refreshToken';
  //* errors
  static const String message = 'message';
  static const String error = 'error';
  static const String statusCode = 'statusCode';
}
