import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/shared/bottom_navigation.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';

import '../../../core/shared/news_article_tile_widget.dart';
import '../../../core/themes/myTheme.dart';

class FavoriteNews  extends StatefulWidget {
  const FavoriteNews({super.key});

  @override
  State<FavoriteNews> createState() => _FavoriteNewsState();
}

class _FavoriteNewsState extends State<FavoriteNews> {
  @override
  Widget build(BuildContext context) {
    var favList = BlocProvider.of<HomeCubit>(context).wishlist;
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      body:Padding(
          padding: EdgeInsets.all(22),
      child: Column(

          children: [

            Text(
              "Favorites",
              style: MyTheme.myTheme.textTheme.displayLarge,
            ),

           Expanded(child: ListView.separated(

               itemBuilder: (context, index) {
                 return NewsArticleTileWidget(
                   author:favList[index].author,
                   title:favList[index].title,
                   date:favList[index].publishedAt,
                   imageUrl:favList[index].imageUrl, //imageUrl
                   articleUrl:favList[index].articleUrl,

                   articleModel: favList[index],

                 )

                 //adding the required animations at the end
                     .animate()
                     .slideX(
                     begin: -10,
                     end: 0,
                     duration: const Duration(seconds: 1),
                     curve: Curves.fastEaseInToSlowEaseOut,
                     delay:
                     Duration(milliseconds: 200 * index));
               }, separatorBuilder: (context, index) {
                 return Divider();
               },

               itemCount:favList.length,
           ),
           ) ,



        ],

      ),


      ) ,
    );
  }
}
