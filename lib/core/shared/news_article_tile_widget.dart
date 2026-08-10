import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/shared/button_widget.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';

import '../../features/home/data/model/aticle_model.dart';
import '../../features/home/widgets/web/article_web_view.dart';

class NewsArticleTileWidget extends StatefulWidget {
  const NewsArticleTileWidget({
    super.key,
    this.author,
    this.date,
    this.title,
    this.imageUrl,
    this.articleUrl,
    required this.articleModel,
  });
  final String? author;
  final String? date;
  final String? title;
  final String? imageUrl;
  final String? articleUrl;
  final ArticleModel articleModel;

  @override
  State<NewsArticleTileWidget> createState() => _NewsArticleTileWidgetState();
}

class _NewsArticleTileWidgetState extends State<NewsArticleTileWidget> {
  void _openArticle() {
    final url = widget.articleUrl;
    if (url == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleView(
          articleUrl: url,
          articleName: widget.author ?? sourceName,
        ),
      ),
    );
  }

  String get sourceName => widget.author == null
      ? "Source unknown"
      : widget.author!.length > 15
          ? "${widget.author!.substring(0, 15)}..."
          : widget.author!;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImage(),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 14, color: Colors.black45),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        sourceName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.title ?? "",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                    color: Colors.black87,
                  ),
                ),
                if (widget.date != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14, color: Colors.black38),
                      const SizedBox(width: 4),
                      Text(
                        widget.date!.split("T").first,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(onTap: _openArticle),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        final isFav = context
                            .read<HomeCubit>()
                            .isFavorite(widget.articleModel);
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: IconButton(
                            key: ValueKey(isFav),
                            tooltip: isFav
                                ? 'Remove from favourites'
                                : 'Add to favourites',
                            onPressed: () {
                              context
                                  .read<HomeCubit>()
                                  .addToWishlist(widget.articleModel);
                            },
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav
                                  ? const Color(0xFFE53935)
                                  : Colors.black45,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (widget.imageUrl == null) {
      return Container(
        width: 104,
        height: 104,
        color: Colors.black.withValues(alpha: 0.06),
        child: const Icon(Icons.photo_outlined, size: 34, color: Colors.black26),
      );
    }
    return Image.network(
      widget.imageUrl!,
      width: 104,
      height: 104,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: 104,
          height: 104,
          color: Colors.black.withValues(alpha: 0.05),
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.black38,
            size: 26,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: 104,
          height: 104,
          color: Colors.black.withValues(alpha: 0.06),
          child: const Icon(Icons.image_not_supported_outlined,
              size: 28, color: Colors.black26),
        );
      },
    );
  }
}