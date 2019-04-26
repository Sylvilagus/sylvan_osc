/**
 * Created by Sylva Lee
 * 有必要写一下为什么我又把这个东西挪回pages里了。
 * 只是因为widget里import pages的话我觉得这种结构很恶心。
 * 而这个NewsItem又是制定化的没必要把ontap写活。所以这样吧。
 */

import 'package:flutter/material.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'common_detail.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sylvan_osc/network/httpapi.dart' as HttpApi;

class NewsItem extends StatelessWidget {
  final NewsBrief news;
  final String token;

  NewsItem(this.news, {Key key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(news.title, style: textTheme.title),
            Row(
              children: <Widget>[
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: news.author,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(text: "  ${news.pubDate}", style: textTheme.caption)
                ])),
                Row(
                  children: <Widget>[
                    Icon(Icons.message),
                    Text(news.commentCount.toString())
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (buildContext) {
          return LoadingDetailPage<NewsDetail>(
              bodyBuilder: (detail) {
                return Material(
                  child: WebviewScaffold(url: detail.url),
                );
              },
              requestSender: () {
                return HttpApi.getNewsDetail(token, news.id);
              },
              title: news.title);
        }));
      },
    );
  }
}
