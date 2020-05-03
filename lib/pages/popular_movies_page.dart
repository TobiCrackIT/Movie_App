import 'package:provider_arch/utils/export.dart';


class PopularMoviesPage extends StatefulWidget {
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Consumer<HomeViewModel>(builder: (context, _viewModel, child) {
        if (_viewModel.getCurrentStatus() == Status.FAILED) {
          return Center(child: Text(_viewModel.getErrorMessage()));
        } else if (_viewModel.getCurrentStatus() == Status.SUCCESSFUL) {
          //return Center(child: Text('Successfully fetched movie details'));
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _viewModel.getPopularMoviesList().length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  isThreeLine: true,
                  title: Text(_viewModel.getPopularMoviesList()[index].title),
                  subtitle: Text(
                    "OVERVIEW: ${_viewModel.getPopularMoviesList()[index].overview.toString()}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}