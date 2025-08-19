import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:news_app/features/category/views/category_article_view.dart';
import 'package:news_app/features/category/views/widgets/category_tile_widget.dart';

import '../../../core/themes/myTheme.dart';
import '../../../core/shared/bottom_navigation.dart';

class CategorySelectionView extends StatelessWidget {
  const CategorySelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    //list for categories
    List<String> categoryList = [
      "Cricket",
      "Business",
      "Entertainment",
      "General",
      "Science",
      "Sports",
      "Technology",
      "Music",
      "Gaming",
      "Anime",
      "Health",
      "Education",
      "Crime",
      "Weather"
    ];
    return Scaffold(
      //bottom navigation
      bottomNavigationBar: const BottomNavigation(),

      //main content to be returned
      body: SafeArea(
          child: BlocConsumer<CategoryCubit, CategoryState>(
            listener: (context, state) {
              if (state is CategoryClickedActionState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  CategoryArticleView(categoryName: state.categoryName,)));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text
                    Text(
                      "Categories",
                      style: MyTheme.myTheme.textTheme.displayLarge,
                    ),

                    // Text
                    Text(
                      "Read about various categories as per your interests",
                      style: MyTheme.myTheme.textTheme.displaySmall,
                    ),

                    //categories mapping within the gridview
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 25,
                          ),
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<CategoryCubit>(context).getCategoryAction(categoryList[index]);
                              },
                              child: CategoryTileWidget(
                                  categoryImagePath:
                                  "assets/images/cat${index + 1}.jpg",
                                  categoryName: categoryList[
                                  index]) //adding the required animations at the end

                              //adding the animate addon
                                  .animate()

                              //adding fadeIn effect
                                  .fadeIn(
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.decelerate)

                              //adding the shimmer effect
                                  .shimmer(
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.fastEaseInToSlowEaseOut),
                            );
                          }),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
