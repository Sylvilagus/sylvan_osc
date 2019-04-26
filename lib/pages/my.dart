/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'login.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'package:sylvan_osc/redux/redux.dart';
class MyPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store){
        return  SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("我的"),
              centerTitle: true,
            ),
            body: _body(store),
          ),
        );
      },

    );
  }

  _body(Store store) {
    User user = store.state.user;
    return Container(
      child: user == null ? FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text("登录")
      ) : Text(user.map.toString()),
    );
  }
}
