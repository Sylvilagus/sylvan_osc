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
import 'common_detail.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'news_item.dart';
class IndexPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<IndexPage> {
  Iterator<Future<NewsListResult>> _newsIterator;
  bool loadingMore = false;
  String token;
  @override
  void initState() {
    super.initState();
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
        title: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 30),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).accentColor),
                hintText: "来点感兴趣的关键字？",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none),
                fillColor: Color(0xffffffff),
                filled: true),
          ),
        ),
      )
    ];
  }
  _initData(String token){
    this.token = token;
  }

  _body() {
    return StoreBuilder<AppState>(
      builder: (context, store){
        final token = store.state.tokenResult.accessToken;
        if(_newsIterator == null){
          _initData(token);
        }

        return RefreshableList<NewsBrief, NewsListResult>(
          converter: (result){
            return result.newsList;
          },
          itemBuilder: (buildContext, entity, position){
            return NewsItem(entity, token: token);
          },
          msgOutput: (msg){
            ToastUtil.showToast(msg);
          },
          responseEntityErrorDescription: (entity){
            return entity.errorDescription;
          },
          responseEntityIsSuccess: (entity){
            return entity.success;
          },
          responseIteratorBuilder: (){
            return HttpApi.getNewsListGenerator(token).iterator;
          },
        );
      }
    );
  }

}
