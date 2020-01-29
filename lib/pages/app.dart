
import 'package:flutter/material.dart';
import 'package:wheater_app/generated/i18n.dart';
import 'package:wheater_app/shared/shared.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // accentColor: colorStyle.theme870051(),
          backgroundColor: Colors.white,
          // appBarTheme: AppBarTheme(color: Colors.blue),
          // bottomAppBarColor: Colors.white
          ),
      localizationsDelegates: const <
          LocalizationsDelegate<WidgetsLocalizations>>[I18n.delegate],
      routes: Routers().route,
      initialRoute: Routers.home,
    );
  }
}
