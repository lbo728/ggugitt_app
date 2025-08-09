import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_constants.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({
    super.key,
  });

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);

    if (controller.platform is WebKitWebViewController) {
      final WebKitWebViewController webKitController =
          controller.platform as WebKitWebViewController;
      webKitController.setAllowsBackForwardNavigationGestures(false);
    }

    // 웹뷰 설정
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            print('페이지 로딩 시작: $url');
          },
          onPageFinished: (String url) {
            print('페이지 로딩 완료: $url');
          },
          onHttpError: (HttpResponseError error) {
            print('HTTP 에러 발생');
          },
          onWebResourceError: (WebResourceError error) {
            print('웹 리소스 에러: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            print('네비게이션 요청: ${request.url}');

            if (request.url.startsWith('kakaolink://') ||
                request.url.startsWith('kakaotalk://') ||
                request.url.startsWith('kakao')) {
              if (Platform.isIOS) {
                _launchKakaoTalk(request.url);
                return NavigationDecision.prevent;
              }
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(AppConstants.voteUrl));
  }

  Future<void> _launchKakaoTalk(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        print('카카오톡 실행 성공: $url');
      } else {
        print('카카오톡 앱을 실행할 수 없습니다: $url');
      }
    } catch (e) {
      print('카카오톡 실행 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
