class AppConfig {
  static const String ggugittPrd = 'https://ggugitt.com/';
  static const String ggugittDev = 'https://ggugitt-dev.web.app/';

  static const String voteUrl = ggugittPrd;

  // 환경 설정
  static const bool isProduction =
      bool.fromEnvironment('IS_PRODUCTION', defaultValue: false);
  static const bool isDevelopment =
      bool.fromEnvironment('IS_DEVELOPMENT', defaultValue: true);

  // API 설정
  static String get baseUrl => isProduction ? ggugittPrd : ggugittDev;

  // 앱 설정
  static const String appName = '꾸깃';
  static const String appVersion = '1.0.0';
}
