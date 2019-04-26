/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../constant/http_constant.dart';
import 'package:redux/redux.dart';
import 'package:sylvan_osc/main.dart';
import 'home.dart';
import 'package:sylvan_osc/redux/redux.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'package:sylvan_osc/util/toast.dart';
import 'package:sylvan_osc/network/httpapi.dart' as HttpApi;

class OauthPage extends StatefulWidget {
  @override
  _OauthPageState createState() => _OauthPageState();
}

class _OauthPageState extends State<OauthPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool userInfoGot = false;
  @override
  void initState() {
    super.initState();
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      //这个蛋疼的东西会执行多次。。
      if(userInfoGot)
        return;
      print("url = $url");
      if (url.isNotEmpty && url.contains("code=")) {
        String code = Uri.splitQueryString(url.substring(url.indexOf("\?") + 1))["code"];
        HttpApi.getToken(code)
            .then((tokenResult) {
          if(mounted) {
            if(tokenResult.success) {
              MyApp app = context.ancestorWidgetOfExactType(MyApp);
              Store<AppState> store = app.store;
              store.dispatch(TokenUpdateAction(tokenResult));
              HttpApi.getLoginUserInfo(tokenResult.accessToken)
                .then((user){
                if(user.success){
                  userInfoGot = true;
                  _updateUserAndNavigateToMainPage(store, user);
                }else{
                  ToastUtil.showToast("用户信息获取失败：${user.errorDescription}");
                }
              });
            }else{
              ToastUtil.showToast("token获取失败：${tokenResult.errorDescription}");
            }
          }
        });
      }
    });
  }
  _updateUserAndNavigateToMainPage(Store<AppState> store, User user){
    store.dispatch(UserUpdateAction(user));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(
        appBar: AppBar(
          title: Text("授权登录"),
          centerTitle: true,
        ),
        url: OAUTH_URL,
        withJavascript: true,
        withLocalStorage: true,
      ),
    );
  }
}
