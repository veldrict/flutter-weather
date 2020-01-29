import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheater_app/generated/i18n.dart';
import 'package:wheater_app/pages/home/bloc/home_bloc.dart';
import 'package:wheater_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _animation;
  String _city;
  String _country;
  double _lat;
  double _long;
  String _weather;
  String _weatherDetail;
  double _temp;
  String _lastUpdate;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animation = '01d';
    _city = 'Bandung';
    _country = 'Indonesia';
    _lat = 0.0;
    _long = 0.0;
    _weather = 'Sunny';
    _weatherDetail = 'Sunny';
    _searchController.text = '';
    _temp = 0.0;
    _lastUpdate = '-';
  }

  _onRefresh() {
    BlocProvider.of<HomeBloc>(context).add(GetPositionEvent(isRefresh: true));
  }

  _onSearch() {
    BlocProvider.of<HomeBloc>(context)
        .add(SearchEvent(searchText: _searchController.text));
    // _searchController.text = '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    I18n i18n = I18n.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _onRefresh,
          )
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {
          if (state is HomeLocationReady) {
            _animation = state.data.weather[0].icon;
            _city = state.data.name;
            _country = state.data.sys.country;
            _weather = state.data.weather[0].main;
            _weatherDetail = state.data.weather[0].description;
            _lat = state.data.coord.lat;
            _long = state.data.coord.lon;
            _temp = state.data.main.temp - 273.15;
            _lastUpdate = state.data.lastUpdate;
          }
          if (state is HomeSearch) {
            _searchController.text = '';
            _animation = state.data.weather[0].icon;
            _city = state.data.name;
            _country = state.data.sys.country;
            _weather = state.data.weather[0].main;
            _weatherDetail = state.data.weather[0].description;
            _lat = state.data.coord.lat;
            _long = state.data.coord.lon;
            _temp = state.data.main.temp - 273.15;
          }
          if (state is HomeError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            return SafeArea(
              child: StackWithProgress(
                isLoading: state is HomeLoading,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue[300]],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          textFormWithIcon(
                              title: i18n.search,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              controller: _searchController,
                              cornerRadius: 8.0,
                              rightIcon: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: IconButton(
                                  icon: Icon(Icons.search, color: Colors.black),
                                  onPressed: _onSearch,
                                ),
                              )),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            i18n.searchCity(_city),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            i18n.country(_country),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            i18n.currentLocation(
                              _lat.toString(),
                              _long.toString(),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            i18n.temp('${_temp.roundToDouble()}'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              child: FlareActor(
                                'assets/weathericons.flr',
                                animation: _animation,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            _weather,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            _weatherDetail,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            i18n.lastUpdate(_lastUpdate),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
