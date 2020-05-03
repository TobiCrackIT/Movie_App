import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_arch/model/movie.dart';
import 'package:provider_arch/remote/api.dart';
import 'package:provider_arch/resources/api_provider.dart';
import 'package:provider_arch/view_model/home_view_model.dart';


class MockApi extends Mock implements API{
  Client client = Client();
}

void main(){

  test('View model should return correct values', ()async{
    final homeViewModel=HomeViewModel();
    List<Movie> topRatedMoviesList;
    List<Movie> list;

    homeViewModel.setErrorMessage('Big error');


    expect(homeViewModel!=null, true);
    expect(homeViewModel.getErrorMessage(),'Big error' );

    var mock_api= MockApi();
    mock_api.client=MockClient((request)async{
      final mapJson = {'id':123,'title':'Money Heist'};
      return Response(json.encode(mapJson),200);
    });

    final res=await mock_api.fetchTopRatedMovies();
    expect(res.statusCode, 200);

    //when(mock_api.fetchTopRatedMovies()).thenAnswer((_)=>Future.value(Response()));
    //final response=mock_api.fetchTopRatedMovies();
    //topRatedMoviesList =MovieList.fromJson(json.decode(response.body)['results']).movieList;
    /*mock_api.fetchTopRatedMovies().then((response){
      if (response.statusCode == 200 || response.statusCode == 201) {
        topRatedMoviesList =
            MovieList.fromJson(json.decode(response.body)['results']).movieList;
        expect(topRatedMoviesList, isNotEmpty);
      }
    });*/

    final apiProvider=ApiProvider();
    apiProvider.client=MockClient((request)async{
      final mapJson = {'id':123};
      return Response(json.encode(mapJson),200);
    });

    final item = await apiProvider.fetchPosts();
    expect(item.id, 123);

    //homeViewModel.popularMoviesList=[Movie(id:'123',title:'Hello world',overview:'Great movie!')];
    //expect(homeViewModel.popularMoviesList, [Movie(id:'123',title:'Hello world',overview:'Great movie!')]);//[Movie(id:'123',title:'Hello world',overview:'Great movie!'),Movie(id:'13',title:'Hello world',overview:'Great movie!'),Movie(id:'23',title:'Hello world',overview:'Great movie!')]);

  });
}