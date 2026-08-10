import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/features/home/views/home_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../core/themes/my_theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyTheme.surface,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Image.asset(
              'assets/logo.jpg',
              width: 300,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                )
                .scale(
                  begin: const Offset(0.75, 0.75),
                  end: const Offset(1, 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutBack,
                ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  "News App",
                  style: const TextStyle(
                    letterSpacing: -.5,
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                  colors: const [
                    MyTheme.primary,
                    MyTheme.secondary,
                    MyTheme.tertiary,
                  ],
                ),
              ],
            )
                .animate()
                .fadeIn(
                  delay: const Duration(milliseconds: 180),
                  duration: const Duration(milliseconds: 500),
                )
                .slideY(
                  begin: 0.12,
                  end: 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                ),

            const SizedBox(height: 20),

            //description about app
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Introducing News App 📰: Your go-to app for breaking news and in-depth analyses tailored to your interests! Stay informed effortlessly with personalized updates, bookmark articles, and engage with a vibrant community. 💡📱',
                textAlign: TextAlign.center,
                style: MyTheme.myTheme.textTheme.displaySmall,
              ),
            )
                .animate()
                .fadeIn(
                  delay: const Duration(milliseconds: 340),
                  duration: const Duration(milliseconds: 500),
                )
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                ),

            const SizedBox(height: 100),

            LoadingAnimationWidget.threeRotatingDots(
              color: MyTheme.myTheme.colorScheme.secondary,
              size: 40,
            )
                .animate()
                .fadeIn(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 400),
                ),
          ],
        ),
      ),
    );
  }
}