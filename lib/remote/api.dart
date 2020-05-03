import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class API{

  String baseURL='https://api.themoviedb.org/3/movie';
  String apiKey='api_key=78672b9eec5df84f1a4f9ae81fa31d59';

  Future<Response> fetchPopularMovies()async{
    String url = "$baseURL/popular?$apiKey";
    Map<String, String> headers = new Map();
    return await http.get(url,headers: headers);
  }

  Future<Response> fetchTopRatedMovies()async{
    String url = "$baseURL/top_rated?$apiKey";
    Map<String,String> headers=new Map();
    return await http.get(url,headers: headers);
  }

  //"$baseURL/popular?api_key=78672b9eec5df84f1a4f9ae81fa31d59"
}