class EndPoints {
  //* base URL
  static const String baseUrl = 'https://collabry.vercel.app/';

  //* Authentication
  static const String signUP = 'auth/register';
  static const String logIn = 'auth/login';
  static const String verificationEmail = 'auth/send-verification-email';
  static const String refreshToken = 'auth/refresh-token';
  static const String sendOtp = 'auth/send-otp';
  static const String verifyOtp = 'auth/verify-otp';

  //* Categories
  static const String categories = 'categories';
  static const String publicationsByCategory = 'categories/publications/';

  //* Publications
  static const String publicationsCreate = 'publications/create';
  static const String publications = 'publications/all';
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
  static const String status = 'status';
  static const String sections = 'sections';
  static const String categoryName = 'categoryName';
  static const String authorId = 'authorId';
  static const String authorName = 'authorName';
  static const String authorEmail = 'authorEmail';
  static const String authorAvatar = 'authorAvatar';
  static const String updatedAt = 'updatedAt';
  static const String createdAt = 'createdAt';
  static const String isLiked = 'isLiked';
  static const String collaborators = 'collaborators';
  static const String user = 'user';

  //* Sections
  static const String content = 'content';
  static const String orderIndex = 'orderIndex';
  static const String type = 'type';
  static const String files = 'files';
  static const String publicationId = 'publicationId';

  //* User
  static const String profileImageUrl = 'profileImageUrl';
  static const String role = 'role';
}
