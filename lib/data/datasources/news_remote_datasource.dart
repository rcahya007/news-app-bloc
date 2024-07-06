import 'package:dartz/dartz.dart';
import 'package:news_app/core/constants/variables.dart';
import 'package:news_app/data/models/response/news_response_model.dart';
import 'package:http/http.dart' as http;

class NewsRemoteDatasource {
  Future<Either<String, NewsResponseModel>> getNews() async {
    final response = await http.get(
      Uri.parse(Variables.urlBase),
    );

    if (response.statusCode == 200) {
      return Right(NewsResponseModel.fromJson(response.body));
    } else {
      return const Left('Something went wrong');
    }
  }

  Future<Either<String, Article>> getNewsDetail(Article? article) async {
    if (article != null) {
      return Right(article);
    } else {
      return const Left('Something went wrong');
    }
  }
}
