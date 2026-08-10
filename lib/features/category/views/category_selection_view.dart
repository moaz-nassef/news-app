import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:news_app/features/category/views/category_article_view.dart';
import 'package:news_app/features/category/views/widgets/category_tile_widget.dart';

import '../../../core/themes/my_theme.dart';
import '../../../core/shared/bottom_navigation.dart';

class CategorySelectionView extends StatelessWidget {
  const CategorySelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    //list for categories
    List<String> categoryList = [
      "Business",
      "Entertainment",
      "General",
      "Health",
      "Science",
      "Sports",
      "Technology",
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
                        builder: (context) => CategoryArticleView(
                            categoryName: state.categoryName)));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
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

                    const SizedBox(height: 24),

                    //categories mapping within the gridview
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.15,
                        ),
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              BlocProvider.of<CategoryCubit>(context)
                                  .getCategoryAction(categoryList[index]);
                            },
                            child: CategoryTileWidget(
                              categoryImagePath:
                                  "assets/images/cat${index + 1}.jpg",
                              categoryName: categoryList[index],
                            )
                                .animate()
                                .fadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                )
                                .slideY(
                                  begin: 0.06,
                                  end: 0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}