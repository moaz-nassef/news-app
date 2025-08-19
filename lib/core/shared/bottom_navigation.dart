import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/views/home_view.dart';

import '../../features/category/views/category_selection_view.dart';
import '../../features/home/views/favorite_news.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(CupertinoIcons.home),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
                  },
                  ),
              IconButton(
                icon: Icon(CupertinoIcons.list_bullet),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategorySelectionView()));
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.globe),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeView()));
                },
              ),
              IconButton(
                icon: Icon(CupertinoIcons.heart),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteNews()));
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
