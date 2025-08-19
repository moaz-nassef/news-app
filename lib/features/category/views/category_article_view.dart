import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/shared/loading_animation.dart';
import 'package:news_app/core/shared/news_article_tile_widget.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../core/shared/bottom_navigation.dart';
import '../../../core/themes/myTheme.dart';

class CategoryArticleView  extends StatefulWidget {
  const CategoryArticleView({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<CategoryArticleView> createState() => _CategoryArticleViewState();
}

class _CategoryArticleViewState extends State<CategoryArticleView> {


  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context).categoryDataLoadingEvent(widget.categoryName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: BlocConsumer<CategoryCubit, CategoryState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Column children
                  children: [
                    // Text
                    GradientText(
                      "${widget.categoryName} related articles",
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600,height: 1),
                      colors: [
                        MyTheme.myTheme.colorScheme.primary,
                        MyTheme.myTheme.colorScheme.secondary,
                        MyTheme.myTheme.colorScheme.tertiary,
                      ],
                    ),

                    //sized box
                    const SizedBox(
                      height: 9,
                    ),

                    // Text
                    Text(
                      "Read all articles related to the category of ${widget.categoryName.toLowerCase()} and explore more categories as per your personal interests, preferences and enjoy reading.",
                      style: MyTheme.myTheme.textTheme.displaySmall,
                    ),

                    //mapping the articles
                  state is CategoryDataLoadingState?

                    LoadingWidget():

                      state is CategoryDataLoadedState?

                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                       state.articleList.length,
                        itemBuilder: (context, index) {
                          // Return your news article tile widget here based on index
                          return NewsArticleTileWidget(
                              author:state
                                  .articleList[index].author,
                              title:state
                                  .articleList[index].title,
                              date:state
                                  .articleList[index].publishedAt,
                              imageUrl:state
                                  .articleList[index]
                                  .imageUrl, //imageUrl
                              articleUrl:state
                                  .articleList[index].articleUrl,

                            articleModel: state.articleList[index],

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
                        },
                      ),
                    ):
                    Center(child: Text("Not Founded"),),
                  ]),
            ),
          ));
  },
),
    );


}}
