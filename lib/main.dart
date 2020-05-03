import 'package:provider_arch/utils/export.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BasePage(),
      ),
    );
  }
}

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Provider Achitecture',
            ),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 20, color: Color(0xff000000)),
              labelColor: Colors.blue,
              isScrollable: true,
              unselectedLabelColor: Color(0xffffffff),
              tabs: [
                Tab(
                  text: 'Popular',
                ),
                Tab(
                  text: 'Top Rated',
                ),
                /*Tab(
                  text: 'Latest',
                ),*/
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[PopularMoviesPage(),TopRatedMoviesPage()]),
        ));
  }
}


