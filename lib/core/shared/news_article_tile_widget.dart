import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/shared/button_widget.dart';
import 'package:news_app/features/home/viewModel/home_cubit.dart';

import '../../features/home/data/model/aticle_model.dart';
import '../../features/home/widgets/web/article_web_view.dart';
import '../themes/myTheme.dart';

class NewsArticleTileWidget  extends StatefulWidget {
  const NewsArticleTileWidget({super.key, this.author, this.date, this.title, this.imageUrl, this.articleUrl, required this.articleModel});
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
  @override
  Widget build(BuildContext context) {
    final isFav = BlocProvider.of<HomeCubit>(context).isFavorite(widget.articleModel);

    return Container(
      margin: const EdgeInsets.only(top: 8, left: 3, right: 3),
      child: Column(
        children: [
          Row(
            children: [
              // Left part: Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: widget.imageUrl != null
                    ? Image.network(
                  widget.imageUrl.toString(),
                  width: 118,
                  height: 118,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                        color: Colors.black12,
                        width: 118,
                        height: 118,
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.black54, size: 30));
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 118,
                      height: 118,
                      color: Colors.black12,
                      child: const Icon(Icons.error_outline, size: 30),
                    );
                  },
                )
                    : Container(
                  height: 118,
                  width: 118,
                  color: Colors.black12,
                  child: const Icon(Icons.photo, size: 40),
                ),
              ),
              const SizedBox(width: 15),

              // Content
              SizedBox(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author and uploading date
                    Text(
                      widget.author != null && widget.date != null
                          ? "${widget.author!.length > 15 ? widget.author!.substring(0, 15) : widget.author}... ${widget.date!.split("T")[0]}"
                          : "Source unknown",
                      style: MyTheme.myTheme.textTheme.displaySmall,
                    ),

                    const SizedBox(height: 3),

                    // Title of the article
                    Text(
                      widget.title ?? "",
                      maxLines: 3,
                      style: MyTheme.myTheme.textTheme.displayMedium,
                    ),

                    const SizedBox(height: 5),

                    // Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ArticleView(articleUrl: widget.articleUrl!,articleName: widget.author.toString(),)));
                          },
                          height: 36,
                          width: 129.62,
                        ),
                        IconButton(
                          onPressed: () {

                              BlocProvider.of<HomeCubit>(context).addToWishlist(widget.articleModel);


                          },
                          icon: isFav?const Icon(Icons.favorite,color: Colors.red,):const Icon(Icons.favorite_border),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Separator line
          Container(
            margin: const EdgeInsets.only(top: 23),
            color: Colors.black26,
            width: double.maxFinite,
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
