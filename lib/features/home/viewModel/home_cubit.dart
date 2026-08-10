import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/features/home/data/model/aticle_model.dart';
import 'package:news_app/features/home/data/repo/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeServices) : super(HomeInitial());

  final HomeServices _homeServices;

  Future<void> getHomeData() async {
    emit(HomeDataLoadingState());

    try {
      var list = await _homeServices.getIndianHeadlines();

      if (list != null) {
        emit(HomeDataLoadedState(articleList: list));
      } else {
        emit(HomeDataLoadingErrorState());
      }
    } catch (e) {
      debugPrint('HomeCubit error: $e');
      emit(HomeDataLoadingErrorState());
    }
  }

  List<ArticleModel> wishlist = [];

  bool isFavorite(ArticleModel product) {
    return wishlist.any((item) => item.articleUrl == product.articleUrl);
  }

  void addToWishlist(ArticleModel product) {
    if (isFavorite(product)) {
      wishlist.removeWhere((item) => item.articleUrl == product.articleUrl);
    } else {
      wishlist.add(product);
    }
    final current = state;
    emit(current is HomeDataLoadedState
        ? HomeDataLoadedState(articleList: current.articleList)
        : FavoriteHelper());
  }
}
