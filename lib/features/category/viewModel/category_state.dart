part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
class CategoryClickedActionState extends CategoryState{
  final String categoryName;
  CategoryClickedActionState({required this.categoryName});
}


//=======================================================//
// these states are only for the category article list page where the articles of a specific categories are listed

// 1. suppose the category news articles are getting loaded
class CategoryDataLoadingState extends CategoryState {}

// 2. suppose the category news articles are loaded successfully
class CategoryDataLoadedState extends CategoryState {
  final List<ArticleModel> articleList;

  CategoryDataLoadedState({required this.articleList});
}

// 3. suppose the category news articles failed to load
class CategoryDataErrorState extends CategoryState {}