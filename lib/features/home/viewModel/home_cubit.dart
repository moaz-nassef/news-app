import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/data/model/aticle_model.dart';
import 'package:news_app/features/home/data/repo/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeServices ) : super(HomeInitial());


final HomeServices _homeServices ;
  Future<void> getHomeData()
      async {
try{
  emit(HomeDataLoadingState());

  var list = await _homeServices.getIndianHeadlines();

  if(list != null){
    emit(HomeDataLoadedState(articleList: list));
  }else{
    emit(HomeDataLoadingErrorState());
  }

}catch(e){
  print("LLLLLLLL : $e");
}
    // //state to show the data loading screen
    // emit(HomeDataLoadingState());
    // var result = await _homeServices.getIndianHeadlines();
    //
    // //if the result is not false then -->
    // if(result != false){
    //   //emit the data successfully loaded state : op
    //   emit(HomeDataLoadedState(articleList: result["articleList"]));
    // }
  }
  // List to hold the favorited items
   List<ArticleModel> wishlist = [];
  bool isFav = false;
  // Function to add item to the wishlist
  void addToWishlist(ArticleModel product) {
    wishlist.add(product);
    if (!wishlist.contains(product)) {
      wishlist.add(product);  // Add to wishlist if not already present
      emit(FavoriteHelper());
      print("Product added to wishlist: ${product.title}");
    } else {
      print("Product is already in the wishlist.");
    }
    print("objehhhhhhhhhhhhct""");// Re-emit the current state to rebuild the UI
  }
  bool isFavorite(ArticleModel product) {
    return wishlist.contains(product);
  }


}
