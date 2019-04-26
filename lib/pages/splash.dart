/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'oauth.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OauthPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(child: Text("这是个引导页")),
    );
  }
}
