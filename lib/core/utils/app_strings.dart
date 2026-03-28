class AppStrings {
  AppStrings._();

  // image path
  static const String icon = 'assets/icons';
  static const String image = 'assets/images';
  static const String intro = 'assets/intro';

  //   options.headers[] onRequest
  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String socketIdKey = 'X-Socket-ID';
  static const String secretKey = "X-secret-key";
  static const String timezoneKey = "X-timezone";
  static const String userLat = "X-user-lat";
  static const String userLng = "X-user-lng";
  static const String localizationKey = "Accept-Language";
  static const String deviceIdKey = "X-device-id";
  static const String appVersionKey = "X-app-version";
  static const String applicationJson = 'application/json';
  static const String success = "success";
  static const String successRegisterKey = "Success Register";
  static const String tokenKey = "Authorization";

  // error handler
  static const String badRequestError = "Bad Request";
  static const String noContent = "No Content";
  static const String forbiddenError = "Forbidden";
  static const String unauthorizedError = "Unauthorized";
  static const String notFoundError = "Not Found";
  static const String conflictError = "Conflict";
  static const String internalServerError = "ServerError Please Try again";
  static const String unknownError = "Unknown Error";
  static const String timeoutError = "Timeout Error";
  static const String defaultError = "Default Error";
  static const String cacheError = "Cache Error";
  static const String noInternetError = "No Internet Connection";

  //
  static const String emailRegx =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
  static const String noRouteFound = 'No Route Found';
}
