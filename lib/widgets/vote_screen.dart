import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
  late InAppWebViewController inAppController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(),
      onRefresh: () async {
        try {
          if (Platform.isAndroid) {
            await inAppController.reload();
          } else if (Platform.isIOS) {
            final currentUrl = await inAppController.getUrl();
            if (currentUrl != null) {
              await inAppController.loadUrl(
                  urlRequest: URLRequest(url: currentUrl));
            } else {
              await inAppController.reload();
            }
          } else {
            await inAppController.reload();
          }
        } finally {
          // endRefreshing은 onLoadStop/onReceivedError에서도 호출되지만,
          // 안전하게 보장하기 위해 여기서도 시도
          pullToRefreshController.endRefreshing();
        }
      },
    );
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (await inAppController.canGoBack()) {
          await inAppController.goBack();
        } else {
          if (context.mounted) {
            Navigator.of(context).pop(result);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(AppConstants.voteUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              allowsBackForwardNavigationGestures: true,
            ),
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              inAppController = controller;
            },
            onLoadStop: (controller, url) async {
              pullToRefreshController.endRefreshing();
            },
            onReceivedError: (controller, request, error) {
              pullToRefreshController.endRefreshing();
            },
            shouldOverrideUrlLoading: (controller, navAction) async {
              final url = navAction.request.url?.toString() ?? '';
              if (url.isNotEmpty) {
                debugPrint('네비게이션 요청: $url');
              }

              if (url.startsWith('kakaolink://') ||
                  url.startsWith('kakaotalk://') ||
                  url.startsWith('kakao')) {
                if (Platform.isIOS) {
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                  return NavigationActionPolicy.CANCEL;
                }
              }

              return NavigationActionPolicy.ALLOW;
            },
          ),
        ),
      ),
    );
  }
}
