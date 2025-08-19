part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class HomeDataLoadingState extends HomeState{}



//if the data is loaded successfully
class HomeDataLoadedState extends HomeState{
  final List<ArticleModel> articleList;
  HomeDataLoadedState({required this.articleList});
}



//error event
class HomeDataLoadingErrorState extends HomeState{}
class FavoriteHelper extends HomeState{}
