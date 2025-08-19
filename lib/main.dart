import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/themes/myTheme.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:news_app/features/category/viewModel/repo/category_news.dart';
import 'package:news_app/features/home/data/repo/home_services.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';
import 'package:news_app/features/splash/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          HomeCubit(HomeServices())
            ..getHomeData(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit(GetCategoricalArticles()),
        ),
      ],
      child: MaterialApp(
        theme: MyTheme.myTheme,

        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}

