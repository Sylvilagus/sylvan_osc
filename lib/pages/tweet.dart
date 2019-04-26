/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sylvan_osc/redux/redux.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'package:sylvan_osc/network/httpapi.dart' as HttpApi;
import 'package:sylvan_osc/util/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:sylvan_osc/widget/refreshable_list.dart';
import 'tweet_item.dart';

class TweetPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<TweetPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final _categoryNames = ["最新", "热门", "我的"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categoryNames.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: _headerSliverBuilder, body: _body());
  }

  List<Widget> _headerSliverBuilder(
      BuildContext buildContext, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text("动弹"),
        centerTitle: true,
        floating: true,
        snap: true,
        pinned: true,
        bottom: TabBar(
            tabs: _categoryNames.map((name) => Tab(text: name)).toList(),
            controller: _tabController),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      )
    ];
  }

  _body() {
    return StoreBuilder<AppState>(builder: (context, store) {
      final token = store.state.tokenResult.accessToken;
      return TabBarView(children: [
        _createRefreshableListWidget(token, HttpApi.TweetCatalog.LATEST),
        _createRefreshableListWidget(token, HttpApi.TweetCatalog.HOT),
        _createRefreshableListWidget(token, store.state.user.id)
      ],
        controller: _tabController,);

    });
  }
  Widget _createRefreshableListWidget(String token, dynamic catalog){
    return RefreshableList<TweetBrief, TweetListResult>(
      converter: (result) {
        return result.tweetList;
      },
      itemBuilder: (buildContext, entity, position) {
        return TweetItem(entity, token: token);
      },
      msgOutput: (msg) {
        ToastUtil.showToast(msg);
      },
      responseEntityErrorDescription: (entity) {
        return entity.errorDescription;
      },
      responseEntityIsSuccess: (entity) {
        return entity.success;
      },
      responseIteratorBuilder: () {
        return HttpApi.getTweetListGenerator(token, catalog: catalog).iterator;
      }
    );
  }
}
