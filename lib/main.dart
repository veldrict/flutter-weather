import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wheater_app/pages/app.dart';
import 'package:wheater_app/simple_bloc_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  var appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  runApp(App());
}
