/**
 * Created by Sylva Lee
 */
import 'package:flutter/material.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'dart:ui';
import 'package:sylvan_osc/network/httpapi.dart' as HttpApi;
import 'common_detail.dart';
import 'package:sylvan_osc/widget/refreshable_list.dart';
import 'package:sylvan_osc/util/toast.dart';
import 'comment_item.dart';

class TweetItem extends StatelessWidget {
  final String token;
  final TweetBrief tweetBrief;

  TweetItem(this.tweetBrief, {Key key, @required this.token}) : super(key: key);

  Widget _tweetBody(TweetDetail detail, double leftWidth, double rightWidth,
      BuildContext context) {
    var theme = Theme.of(context);
    return Material(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //头像和用户名
          Container(
            width: leftWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: Image.network(detail.portrait),
                ),
                Text(
                  detail.author,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                )
              ],
            ),
          ),
          //正文
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(detail.body),
                SizedBox(
                  height: 10,
                ),
                detail.imageSmall != null
                    ? Image.network(detail.imageSmall)
                    : SizedBox(),
                Text(
                  "${detail.pubDate}  回复：${detail.commentCount}",
                  style: theme.textTheme.caption,
                ),
              ],
            ),
            width: rightWidth,
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQueryData.fromWindow(window).size.width;
    var leftWidth = screenWidth * 0.2;
    var rightWidth = screenWidth * 0.72;
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //头像和用户名
            Container(
              width: leftWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipOval(
                    child: Image.network(tweetBrief.portrait),
                  ),
                  Text(
                    tweetBrief.author,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                  )
                ],
              ),
            ),
            //正文
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(tweetBrief.body),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${tweetBrief.pubDate}  回复：${tweetBrief.commentCount}",
                    style: textTheme.caption,
                  )
                ],
              ),
              width: rightWidth,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (buildContext) {
          return Material(
            child: LoadingDetailPage<TweetDetail>(
                bodyBuilder: (detail) {
                  return RefreshableList<Comment, CommentListResult>(
                      converter: (result){
                        return result.commentList;
                      },
                      itemBuilder: (context, comment, position){
                        return CommentItem(comment);
                      },
                      responseIteratorBuilder: (){
                        return HttpApi.getCommentListGenerator(token, HttpApi.CommentCatalog.TWEET, detail.id).iterator;
                      },
                      responseEntityIsSuccess: (result){
                        return result.success;
                      },
                      responseEntityErrorDescription: (result){
                        return result.errorDescription;
                      },
                      msgOutput: (msg){
                        ToastUtil.showToast(msg);
                      },
                    headerBuilder: (){
                        return _tweetBody(detail, leftWidth, rightWidth, context);
                    },
                  );
                },
                requestSender: () {
                  return HttpApi.getTweetDetail(token, tweetBrief.id);
                },
                title: "动弹详情"),
          );
        }));
      },
    );
  }
}
