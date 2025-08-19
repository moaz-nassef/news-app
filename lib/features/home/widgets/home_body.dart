import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';
import 'package:news_app/features/home/widgets/grediant_container.dart';

import '../../../core/shared/loading_animation.dart';
import '../../../core/shared/news_article_tile_widget.dart';
import '../../../core/themes/myTheme.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: MyTheme.myTheme.textTheme.displayLarge,
              ),

              // Text
              Text(
                "Read your favourite news articles in just one click",
                style: MyTheme.myTheme.textTheme.displaySmall,
              ),

              // Gradient container
              const GradientContainer(),
              const SizedBox(
                height: 16,
              ),

              // Text
              // Text(
              //   "Top headlines from India",
              //   style: MyTheme.myTheme.textTheme.labelMedium,
              // ),
              state is HomeDataLoadingState?

              LoadingWidget():
                  state is HomeDataLoadedState?

              Expanded(child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.articleList.length,
                  itemBuilder: (context, index) {
                    var articlesList =state.articleList[index];
                    return NewsArticleTileWidget(
                      author:  //author
                         articlesList
                          .author,
                      title: articlesList
                          .title,
                      date: articlesList
                          .publishedAt,
                      imageUrl: articlesList
                          .imageUrl,
                      articleUrl:articlesList
                        .articleUrl,
                      articleModel: articlesList,
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
                  },),
              ):Center(child: Text("Not founded "),)

            ],
          ),
        );
      },
    );
  }
}
