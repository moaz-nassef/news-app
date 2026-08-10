import 'package:flutter/material.dart';
import 'package:news_app/core/shared/bottom_navigation.dart';
import 'package:news_app/features/home/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
      bottomNavigationBar: BottomNavigation(currentIndex: 0),
    );
  }
}