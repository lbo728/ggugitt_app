class AppConstants {
  // 앱 정보
  static const String appName = '꾸깃';
  static const String appVersion = '1.0.0';

  // 디자인 시스템
  static const double defaultPadding = 24.0;
  static const double defaultSpacing = 16.0;
  static const double defaultRadius = 8.0;

  // 애니메이션
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // 에러 메시지
  static const String networkErrorMessage = '네트워크 연결을 확인해주세요.';
  static const String generalErrorMessage = '오류가 발생했습니다. 다시 시도해주세요.';
  static const String timeoutErrorMessage = '요청 시간이 초과되었습니다. 다시 시도해주세요.';
}
