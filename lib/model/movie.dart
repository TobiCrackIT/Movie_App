class Movie{
  var id;
  String title;
  String overview;

  Movie({this.id,this.title,this.overview});

  factory Movie.fromJson(Map<String,dynamic> json)=>
      Movie(id: json['id'],overview: json['overview'],title: json['title'] as String);

  Map<String,dynamic> toJson(Movie movie)=><String,dynamic>{
    'id':movie.id,
    'title':movie.title,
    'overview':movie.overview
  };
}

class MovieList{
  final List<Movie> movieList;
  MovieList(this.movieList);

  factory MovieList.fromJson(List parsedJson){
    var list=parsedJson;
    List<Movie> newList=list.map((i)=>Movie.fromJson(i)).toList();
    return MovieList(newList);
  }
}