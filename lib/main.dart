import 'package:flutter/material.dart';
import 'pages/splash.dart';
import 'package:redux/redux.dart';
import 'redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main(){
  final store = Store(appReducer,
      initialState: AppState.empty()
  );
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {

  final Store<AppState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
