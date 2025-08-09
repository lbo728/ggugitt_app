import 'package:flutter/material.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            children: [
              Text('투표 탭'),
            ],
          ),
        ),
      ),
    );
  }
}
