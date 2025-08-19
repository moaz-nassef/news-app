import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/features/home/views/home_view.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../core/themes/myTheme.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 10),() {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomeView() ));
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        //image asset
        Image.asset(
        'assets/logo.jpg',
        width: 340,
      ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Flutter", style: MyTheme.myTheme.textTheme.displayLarge),
              GradientText("News App",
                  style: const TextStyle(
                    letterSpacing: -.5,
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                  ),
                  colors: [
                    MyTheme.myTheme.colorScheme.primary,
                    MyTheme.myTheme.colorScheme.secondary,
                    MyTheme.myTheme.colorScheme.tertiary,
                  ])
            ],
          ),
           SizedBox(height: 20),

          //description about app
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Introducing News App 📰: Your go-to app for breaking news and in-depth analyses tailored to your interests! Stay informed effortlessly with personalized updates, bookmark articles, and engage with a vibrant community. 💡📱',
              textAlign: TextAlign.center,
              style: MyTheme.myTheme.textTheme.displaySmall,
            ),
          ),

          const SizedBox(height: 100),

          LoadingAnimationWidget.threeRotatingDots (color:MyTheme.myTheme.colorScheme.secondary , size: 40)
    ],
      ),
    ),
    );
  }
}
