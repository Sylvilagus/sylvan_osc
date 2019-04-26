/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
          centerTitle: true,
        ),
        body: _body(),
      ),
    );
  }
  _body(){
    return Container(
      child: Text("登录"),
    );
  }
}
