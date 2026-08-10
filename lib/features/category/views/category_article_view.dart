import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/shared/loading_animation.dart';
import 'package:news_app/core/shared/news_article_tile_widget.dart';
import 'package:news_app/features/category/viewModel/category_cubit.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../core/shared/bottom_navigation.dart';
import '../../../core/themes/my_theme.dart';

class CategoryArticleView extends StatefulWidget {
  const CategoryArticleView({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryArticleView> createState() => _CategoryArticleViewState();
}

class _CategoryArticleViewState extends State<CategoryArticleView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context)
        .categoryDataLoadingEvent(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(
                    "${widget.categoryName} related articles",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                    colors: [
                      MyTheme.myTheme.colorScheme.primary,
                      MyTheme.myTheme.colorScheme.secondary,
                      MyTheme.myTheme.colorScheme.tertiary,
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Read all articles related to the category of ${widget.categoryName.toLowerCase()} and explore more categories as per your personal interests, preferences and enjoy reading.",
                    style: MyTheme.myTheme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: _buildBody(state)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(CategoryState state) {
    if (state is CategoryDataLoadingState) {
      return const LoadingWidget();
    }

    if (state is CategoryDataLoadedState) {
      if (state.articleList.isEmpty) {
        return const _MessageWidget(
          icon: Icons.search_off_rounded,
          message: "No articles found for this category.",
          onRetry: null,
        );
      }
      return ListView.builder(
        itemCount: state.articleList.length,
        itemBuilder: (context, index) {
          final article = state.articleList[index];
          return NewsArticleTileWidget(
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
              );
        },
      );
    }

    if (state is CategoryDataErrorState) {
      final cubit = context.read<CategoryCubit>();
      return _MessageWidget(
        icon: Icons.wifi_off_rounded,
        message: "Something went wrong while loading articles.",
        onRetry: () => cubit.categoryDataLoadingEvent(widget.categoryName),
      );
    }

    return const SizedBox.shrink();
  }
}

class _MessageWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback? onRetry;

  const _MessageWidget({required this.icon, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 52, color: Colors.black26),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: MyTheme.myTheme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ],
      ),
    );
  }
}