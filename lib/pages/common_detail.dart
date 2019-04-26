/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
typedef BodyBuilder<ResponseEntity> = Widget Function(ResponseEntity responseEntity);
typedef RequestSender<ResponseEntity> = Future<ResponseEntity> Function();
class LoadingDetailPage<ResponseEntity> extends StatefulWidget {
  final String title;
  final BodyBuilder<ResponseEntity> bodyBuilder;
  final RequestSender<ResponseEntity> requestSender;
  final bool needAppBar;
  LoadingDetailPage({Key key, @required this.bodyBuilder, @required this.requestSender, @required this.title, this.needAppBar = true}): super(key: key);

  @override
  _LoadingDetailPageState<ResponseEntity> createState() => _LoadingDetailPageState<ResponseEntity>();
}

class _LoadingDetailPageState<ResponseEntity> extends State<LoadingDetailPage<ResponseEntity>> {
  ResponseEntity _responseEntity;
  
  @override
  void initState() {
    super.initState();
    widget.requestSender().then((entity){
      setState(() {
        _responseEntity = entity;
      });
      widget?.bodyBuilder(entity);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.needAppBar ? NestedScrollView(
      headerSliverBuilder: _headerSliverBuilder,
      body: _body(),
    ) : _body();
  }
  Widget _body(){
    return _responseEntity == null ? _loadingView() : widget.bodyBuilder(_responseEntity);
  }
  Widget _loadingView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(height: 10,),
        Text("正在加载", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),)
      ],
    );
  }
  List<Widget> _headerSliverBuilder(
      BuildContext buildContext, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text(widget.title??"无标题"),
        leading: BackButton(
          color: Color(0xffffffff),
        ),
      )
    ];
  }
}


