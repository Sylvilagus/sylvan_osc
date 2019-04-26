/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'types.dart';
import 'dart:ui';

typedef IndexedEntityWidgetBuilder<Entity> = Widget Function(
    BuildContext context, Entity entity, int index);
typedef IndependentWidgetBuilder = Widget Function();

class RefreshableList<Entity, ResponseEntity> extends StatefulWidget {
  final RefreshCallback onRefresh;
  final ResponseEntityToEntityList<Entity, ResponseEntity> converter;
  final IndependentWidgetBuilder loadMoreWidgetBuilder;
  final IndependentWidgetBuilder headerBuilder;
  final IndexedEntityWidgetBuilder<Entity> itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final ResponseIteratorBuilder<ResponseEntity> responseIteratorBuilder;
  final ResponseEntityIsSuccess<ResponseEntity> responseEntityIsSuccess;
  final ResponseEntityErrorDescription<ResponseEntity>
      responseEntityErrorDescription;
  final MsgOutput msgOutput;
  final IndependentWidgetBuilder emptyViewBuilder;

  RefreshableList(
      {Key key,
      this.onRefresh,
      @required this.converter,
      this.loadMoreWidgetBuilder,
      @required this.itemBuilder,
      this.separatorBuilder,
      this.headerBuilder,
      this.emptyViewBuilder,
      @required this.responseIteratorBuilder,
      @required this.responseEntityIsSuccess,
      @required this.responseEntityErrorDescription,
      @required this.msgOutput})
      : super(key: key);

  @override
  _RefreshableListState<Entity, ResponseEntity> createState() =>
      _RefreshableListState<Entity, ResponseEntity>();
}

class _RefreshableListState<Entity, ResponseEntity>
    extends State<RefreshableList<Entity, ResponseEntity>> {
  List<Entity> _entities = [];
  Iterator<Future<ResponseEntity>> _responseIterator;
  bool loading = false;
  bool noMore = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _responseIterator = widget.responseIteratorBuilder();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _responseIterator = widget.responseIteratorBuilder();
        _entities.clear();
        if (widget.onRefresh != null) {
          widget.onRefresh();
        }
        _loadMore();
        return null;
      },
      child: _buildListView(),
    );
  }

  Widget _buildListView() {
    if (_entities == null) _entities = [];
    var hasHeader = widget.headerBuilder != null;
    return ListView.separated(
        itemBuilder: (context, position) {
          if (hasHeader) {
            if (position > 0 && _entities.length == 0) {
              return _buildEmptyView();
            }
            if (position == 0) {
              return widget.headerBuilder();
            }
            if (position == _entities.length + 1) {
              _loadMore();
              return (widget.loadMoreWidgetBuilder ??
                  defaultLoadMoreViewBuilder)();
            } else {
              Entity entity = _entities[position - 1];
              return widget.itemBuilder(context, entity, position);
            }
          } else {
            if (_entities.length == 0) {
              return _buildEmptyView();
            }
            if (position == _entities.length) {
              _loadMore();
              return (widget.loadMoreWidgetBuilder ??
                  defaultLoadMoreViewBuilder)();
            } else {
              Entity entity = _entities[position];
              return widget.itemBuilder(context, entity, position);
            }
          }
        },
        separatorBuilder: widget.separatorBuilder ?? defaultSeparatorBuilder,
        itemCount: _entities.length + 1 + (hasHeader ? 1 : 0));
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(window).size.height / 3),
        child: loading
            ? defaultRefreshingViewBuilder()
            : Text("空空如也",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20)),
      ),
    );
  }

  Widget defaultSeparatorBuilder(BuildContext context, int index) {
    return Container(
      height: 0.5,
      color: Colors.grey[300],
    );
  }

  Widget defaultRefreshingViewBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 10,
        ),
        Text(
          "正在加载",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
        )
      ],
    );
  }

  Widget defaultLoadMoreViewBuilder() {
    return noMore ? _noMoreView() : _loadingMoreView();
  }
  Widget _loadingMoreView(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          CupertinoActivityIndicator(),
          Padding(child: Text("正在加载..."), padding: EdgeInsets.all(10))
        ]);
  }
  Widget _noMoreView(){
    return InkWell(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(child: Text("没有更多数据了，点击重试"), padding: EdgeInsets.all(10))
          ]),
      onTap: (){
        setState(() {
          noMore = false;
          _loadMore();
        });
      },
    );
  }

  _loadMore() {
    loading = true;
    _responseIterator.moveNext();
    _responseIterator.current.then((responseEntity) {
      if (!mounted) return;
      if (widget.responseEntityIsSuccess(responseEntity)) {
        setState(() {
          var more = widget.converter(responseEntity);
          if(more != null)
            _entities.addAll(more);
          else
            noMore = true;
          loading = false;
        });
      } else {
        widget.msgOutput(widget.responseEntityErrorDescription(responseEntity));
        loading = false;
      }
    });
  }
}
