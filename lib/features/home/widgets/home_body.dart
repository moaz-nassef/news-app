import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/category/views/category_article_view.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';
import 'package:news_app/features/home/widgets/grediant_container.dart';

import '../../../core/shared/loading_animation.dart';
import '../../../core/shared/news_article_tile_widget.dart';
import '../../../core/themes/my_theme.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  static const _categories = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeData();
  }

  void _openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryArticleView(categoryName: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: RefreshIndicator(
            color: MyTheme.myTheme.colorScheme.primary,
            onRefresh: () =>
                BlocProvider.of<HomeCubit>(context).getHomeData(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
              children: [
                _buildHeader(),
                const SizedBox(height: 18),
                const GradientContainer(),
                const SizedBox(height: 20),
                _buildCategoryChips(),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      "Top headlines",
                      style: MyTheme.myTheme.textTheme.displayMedium,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Divider(color: Colors.black12, height: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ..._buildContent(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Discover",
          style: MyTheme.myTheme.textTheme.displayLarge,
        ),
        const SizedBox(height: 4),
        Text(
          "Read your favourite news articles in just one click",
          style: MyTheme.myTheme.textTheme.displaySmall,
        ),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ActionChip(
            onPressed: () => _openCategory(category),
            label: Text(category),
            backgroundColor: Colors.grey.shade100,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: TextStyle(
              color: MyTheme.myTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildContent(HomeState state) {
    if (state is HomeDataLoadingState) {
      return const [
        SizedBox(
          height: 320,
          child: LoadingWidget(),
        ),
      ];
    }

    if (state is HomeDataLoadedState) {
      if (state.articleList.isEmpty) {
        return [_buildMessage("No news available right now.")];
      }
      return state.articleList
          .map(
            (article) => NewsArticleTileWidget(
              author: article.author,
              title: article.title,
              date: article.publishedAt,
              imageUrl: article.imageUrl,
              articleUrl: article.articleUrl,
              articleModel: article,
            )
                .animate()
                .fadeIn(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOut,
                )
                .slideY(
                  begin: 0.08,
                  end: 0,
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                ),
          )
          .toList();
    }

    if (state is HomeDataLoadingErrorState) {
      return [_buildErrorView()];
    }

    return [];
  }

  Widget _buildErrorView() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Icon(Icons.wifi_off_rounded, size: 52, color: Colors.black26),
          const SizedBox(height: 14),
          Text(
            "Something went wrong",
            style: MyTheme.myTheme.textTheme.displayMedium,
          ),
          const SizedBox(height: 6),
          const Text(
            "Please check your connection and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: () =>
                BlocProvider.of<HomeCubit>(context).getHomeData(),
            style: FilledButton.styleFrom(
              backgroundColor: MyTheme.myTheme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.black54, fontSize: 15),
        ),
      ),
    );
  }
}