import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/category/viewModel/repo/category_news.dart';

import '../../home/data/model/aticle_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoricalArticles) : super(CategoryInitial());

  final GetCategoricalArticles categoricalArticles;

  Future<void> getCategoryAction(String categoryName)async
       {
    //emiting the state to navigate to another page
    emit(CategoryClickedActionState(categoryName:categoryName ));
  }

  //method to handle the data loading event of specific category articles
  Future<void> categoryDataLoadingEvent(String categoryName)
    async {
    emit(CategoryDataLoadingState());

    //call the data loading method and emit the data loaded state
    var result = await GetCategoricalArticles.getIndianHeadlines(categoryName);

    //if the result is not false then -->
    if(result != false){
      //emit the data successfully loaded state : op
      emit(CategoryDataLoadedState(articleList: result));
    }
  }


}
