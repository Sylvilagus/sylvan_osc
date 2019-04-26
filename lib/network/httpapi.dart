/**
 * Created by Sylva Lee
 */

import 'http.dart';
import 'package:sylvan_osc/entity/entity.dart';
import 'package:sylvan_osc/constant/http_constant.dart';

Future<TokenResult> getToken(String code) async {
  var resultString = await Get.url(TOKEN_URL)
      .param("client_id", APP_ID)
      .param("client_secret", PRIVATE_KEY)
      .param("grant_type", "authorization_code")
      .param("redirect_uri", REDIRECT_URL)
      .param("code", code)
      .param("dataType", "json")
      .execute();
  return TokenResult.fromJson(resultString);
}

Future<User> getLoginUserInfo(String token) async {
  var resultString = await Get.url(USER_INFO_URL)
      .param("access_token", token)
      .param("dataType", "json")
      .execute();
  return User.fromJson(resultString);
}

enum NewsCatalog {
  _SENSELESS,

  ///全部
  ALL,

  ///综合新闻
  COMPREHENSIVE_NEWS,

  ///软件更新
  SOFTWARE_UPDATE
}
enum CommentCatalog {
  _SENSELESS,

  ///新闻|翻译
  NEWS,

  ///帖子
  POSTINGS,

  ///动弹
  TWEET,

  ///消息
  MESSAGE,

  ///博客
  BLOG
}
enum TweetCatalog {
  ///热门
  HOT,

  ///最新
  LATEST
}

@deprecated
Future<NewsListResult> getNewsList(String token,
    {NewsCatalog catalog = NewsCatalog.ALL, page = 1, pageSize = 20}) async {
  var resultString = await Get.url(NEWS_LIST_URL)
      .param("access_token", token)
      .param("catalog", catalog)
      .param("page", page)
      .param("pageSize", pageSize)
      .param("dataType", "json")
      .execute();
  return NewsListResult.fromJson(resultString);
}

Future<NewsDetail> getNewsDetail(String token, int id) async {
  var resultString = await Get.url(NEWS_DETAIL_URL)
      .param("access_token", token)
      .param("id", id)
      .param("dataType", "json")
      .execute();
  return NewsDetail.fromJson(resultString);
}

Iterable<Future<NewsListResult>> getNewsListGenerator(String token,
    {NewsCatalog catalog = NewsCatalog.ALL, page = 1, pageSize = 20}) sync* {
  while (true) {
    yield Get.url(NEWS_LIST_URL)
        .param("access_token", token)
        .param("catalog", catalog.index)
        .param("page", page)
        .param("pageSize", pageSize)
        .param("dataType", "json")
        .executeWithConverter<NewsListResult>((string) {
      return NewsListResult.fromJson(string);
    });
    page++;
  }
}

Iterable<Future<TweetListResult>> getTweetListGenerator(String token,
    {dynamic catalog = TweetCatalog.LATEST, page = 1, pageSize = 20}) sync* {
  int userParam = 0;
  if (catalog is TweetCatalog) {
    userParam = catalog.index - 1;
  } else {
    userParam = catalog;
  }
  while (true) {
    yield Get.url(TWEET_LIST_URL)
        .param("access_token", token)
        .param("user", userParam)
        .param("page", page)
        .param("pageSize", pageSize)
        .param("dataType", "json")
        .executeWithConverter<TweetListResult>((string) {
      return TweetListResult.fromJson(string);
    });
    page++;
  }
}

Future<TweetDetail> getTweetDetail(String token, int id) async {
  var resultString = await Get.url(TWEET_DETAIL_URL)
      .param("access_token", token)
      .param("id", id)
      .param("dataType", "json")
      .execute();
  return TweetDetail.fromJson(resultString);
}

Iterable<Future<CommentListResult>> getCommentListGenerator(
    String token, CommentCatalog catalog, int id,
    {page = 1, pageSize = 20}) sync* {
  while (true) {
    yield Get.url(COMMENT_LIST_URL)
        .param("access_token", token)
        .param("catalog", catalog.index)
        .param("id", id)
        .param("page", page)
        .param("pageSize", pageSize)
        .param("dataType", "json")
        .executeWithConverter<CommentListResult>((string) {
      return CommentListResult.fromJson(string);
    });
    page++;
  }
}
