import 'package:flutter/material.dart';
import 'package:ggugitt_app/ui/home/widgets/home_screen.dart';
import 'package:ggugitt_app/ui/vote/widgets/vote_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String vote = '/vote';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case vote:
        return MaterialPageRoute(
          builder: (_) => const VoteScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('페이지를 찾을 수 없습니다.'),
            ),
          ),
        );
    }
  }

  static void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(home);
  }

  static void navigateToVote(BuildContext context) {
    Navigator.of(context).pushNamed(vote);
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
