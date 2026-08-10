import 'package:news_app/core/network/news_api_client.dart';
import 'package:news_app/features/home/data/model/aticle_model.dart';

class HomeServices {
  //method to get data
  Future<List<ArticleModel>?> getIndianHeadlines() {
    return fetchTopHeadlines();
  }
}
