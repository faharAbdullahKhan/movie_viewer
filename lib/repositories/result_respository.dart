import 'package:movie_viewer/models/response/popularMovie_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie_viewer/models/response/string.dart';
import 'dart:convert';

abstract class MovieRepository{

  Future<List<Result>> getResult();
}

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<Result>> getResult() async{
    var response = await http.get(Uri.parse(AppURL.url));

    if(response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Result> result = PopularMovieResponse.fromJson(data).results;
      return result;
    } else {
      throw Exception();
      print(Exception().toString());
    }

  }

}