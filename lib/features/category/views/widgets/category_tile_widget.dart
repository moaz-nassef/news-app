import 'package:flutter/material.dart';

class CategoryTileWidget extends StatelessWidget {
  final String categoryImagePath;
  final String categoryName;
  const CategoryTileWidget(
      {super.key, required this.categoryImagePath, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    //stack
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        //to show the background image
        ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              color: Colors.black26,
              colorBlendMode: BlendMode.darken,
              categoryImagePath,
              width: 205,
              height: 158,
              fit: BoxFit.cover,
            )),

        //to show the front layer text representing the category name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2,vertical:24),
          child: Text(
            categoryName,
            style: const TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  }
}
