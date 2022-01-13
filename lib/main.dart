import 'package:amplified_todos/presentation/navigator/app_navigator.dart';
import 'package:amplified_todos/presentation/screens/todo_screen.dart';
import 'package:amplified_todos/presentation/widgets/todo_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/cubit/auth_cubit.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/foundation.dart';
import '../amplifyconfiguration.dart';
import 'data/models/ModelProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  // amplify plugins
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthCubit()..attemptAutoSignIn(),
          child: _amplifyConfigured ? const AppNavigator() : const LoadingView(),
      ),
    );
  }

  void _configureAmplify() async {
    try {
      await Future.wait([
        Amplify.addPlugins([_dataStorePlugin, _apiPlugin, _authPlugin]),
      ]);
      await Amplify.configure(amplifyconfig);
      setState(
        () {
          _amplifyConfigured = true;
        },
      );
      /// Clears out local DataStore
      /// Comment SetState and uncomment DataStore.clear line
      //Amplify.DataStore.clear();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
