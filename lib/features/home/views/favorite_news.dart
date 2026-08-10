import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/shared/bottom_navigation.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';

import '../../../core/shared/news_article_tile_widget.dart';
import '../../../core/themes/my_theme.dart';

class FavoriteNews extends StatelessWidget {
  const FavoriteNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final favorites = context.read<HomeCubit>().wishlist;
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 22, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Favorites",
                    style: MyTheme.myTheme.textTheme.displayLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    favorites.isEmpty
                        ? "Tap the heart on any article to save it here"
                        : "${favorites.length} saved article(s)",
                    style: MyTheme.myTheme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: favorites.isEmpty
                        ? const _EmptyFavorites()
                        : ListView.separated(
                            itemCount: favorites.length,
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final article = favorites[index];
                              return NewsArticleTileWidget(
                                author: article.author,
                                title: article.title,
                                date: article.publishedAt,
                                imageUrl: article.imageUrl,
                                articleUrl: article.articleUrl,
                                articleModel: article,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 60,
            color: Colors.black.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 14),
          const Text(
            "No favorites yet",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            "Start saving articles you love",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}