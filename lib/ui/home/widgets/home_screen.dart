import 'package:flutter/material.dart';
import 'package:ggugitt_app/ui/home/widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
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
              SizedBox(height: 40),
              BrandingTitle(),
              SizedBox(height: 40),
              Expanded(
                child: DescriptionSection(),
              ),
              HeroImage(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
