# 꾸깃 앱

Flutter로 개발된 투표 애플리케이션입니다.

## 프로젝트 구조

```
lib
├─┬─ ui                          # 사용자 인터페이스 레이어
│ ├─┬─ core                      # 핵심 UI 컴포넌트
│ │ ├─┬─ ui                      # 공통 위젯
│ │ │ └─── common_widgets.dart
│ │ └─── themes                  # 테마 설정
│ │   └─── app_theme.dart
│ ├─┬─ home                      # 홈 기능 (정적 콘텐츠)
│ │ └─┬─ widgets                # 홈 화면 위젯
│ │   ├─── home_screen.dart
│ │   └─── home_widgets.dart
│ └─┬─ vote                      # 투표 기능 (웹뷰)
│   └─┬─ widgets                # 투표 화면 위젯
│     └─── vote_screen.dart
├─── config                      # 설정
│   └─── app_config.dart
├─── utils                       # 유틸리티
│   └─── constants.dart
├─── routing                     # 라우팅
│   └─── app_router.dart
├─── main_staging.dart           # 스테이징 환경
├─── main_development.dart       # 개발 환경
└─── main.dart                   # 프로덕션 환경
```

## 테스트 구조

```
test
├─── ui                          # UI 레이어 테스트
└─── utils                       # 유틸리티 테스트

testing
└─── models                      # 테스트용 모델
```

## 아키텍처 특징

이 프로젝트는 **간소화된 아키텍처**를 사용합니다:

- **UI Layer**: 사용자 인터페이스와 사용자 상호작용
- **홈 화면**: 정적 콘텐츠 (브랜딩, 소개)
- **투표 화면**: 웹뷰를 통한 외부 웹사이트 접근
- **설정 관리**: 환경별 설정 (개발/스테이징/프로덕션)

## 주요 기능

- **홈 화면**: 앱 소개 및 브랜딩 (정적 콘텐츠)
- **투표 화면**: 웹뷰를 통한 투표 시스템 접근
- **다크/라이트 테마**: 테마 시스템 지원
- **환경별 설정**: 개발/스테이징/프로덕션 환경 분리
- **카카오톡 연동**: 웹뷰에서 카카오톡 링크 처리

## 시작하기

### 개발 환경

```bash
flutter run -t lib/main_development.dart
```

### 스테이징 환경

```bash
flutter run -t lib/main_staging.dart
```

### 프로덕션 환경

```bash
flutter run -t lib/main.dart
```

## 의존성

- `flutter`: Flutter SDK
- `url_launcher`: URL 실행 (카카오톡 링크 처리)
- `flutter_inappwebview`: 인앱 웹뷰 (투표 시스템)

## 개발 가이드라인

1. **간소화된 구조**: 불필요한 복잡성 제거
2. **웹뷰 중심**: 투표 기능은 웹뷰로 처리
3. **정적 콘텐츠**: 홈 화면은 정적 위젯으로 구성
4. **에러 처리**: 웹뷰 로딩 실패 시 적절한 처리
5. **코드 스타일**: Flutter 공식 린트 규칙 준수

## 빌드

### Android

```bash
flutter build apk
```

### iOS

```bash
flutter build ios
```

## 기술적 특징

- **웹뷰 기반**: 투표 시스템을 웹뷰로 구현하여 유지보수성 향상
- **플랫폼별 처리**: iOS/Android별 카카오톡 링크 처리
- **풀투리프레시**: 웹뷰 새로고침 기능
- **뒤로가기 처리**: 웹뷰 히스토리 관리
