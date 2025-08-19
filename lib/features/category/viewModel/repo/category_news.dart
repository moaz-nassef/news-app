
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../home/data/model/aticle_model.dart';



class GetCategoricalArticles {
  //method to get data
  static dynamic getIndianHeadlines(String category) async {
    //defining the url
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=3bb62a86f53449d59934eacdf7ae37fa';

    //try catch to fetch data
    try {
      //response object
      var response = await http.get(Uri.parse(url));

      //convert the response from a string to a json object with json.decode
      Map<String, dynamic> list = json.decode(response.body);

      //storing the articles in a separate local variable which is a dynamic List
      List<dynamic> articleRawList = list["articles"];

      //creating a list of Article models
      List<ArticleModel> articleModelList = articleRawList
          .map((article) => ArticleModel(
          source: article['source']['name'],
          author: article['author'],
          title: article['title'],
          description: article['description'],
          articleUrl: article['url'],
          imageUrl: article["urlToImage"],
          publishedAt: article["publishedAt"],
          content: article["content"]))
          .toList();

      // //return the result in form a Map
      // Map<String, dynamic> result = {
      //   "articleList": articleModelList,
      //   "totalResults": articleModelList.length,
      //   "success": true
      // };

      //return statement
      return articleModelList;
    } catch (e) {
      //if there is any error then return false
      return false;
    }
  }
}
