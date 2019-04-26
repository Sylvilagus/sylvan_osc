/**
 * Created by Sylva Lee
 */

import 'dart:convert';
class User extends BaseEntity{
  int id;
  String email;
  String name;
  String gender;
  String avatar;
  String location;
  String url;
  User.fromJson(String jsonString) : super.fromJson(jsonString){
    id = map["id"];
    email = map["email"];
    name = map["name"];
    gender = map["gender"];
    avatar = map["avatar"];
    location = map["location"];
    url = map["url"];
  }
}

class BaseEntity{
  String error;
  String errorDescription;
  Map<String, dynamic> map;
  bool get success => error == null;
  BaseEntity.fromJson(String jsonString){
    map = json.decode(jsonString);
    error = map["error"];
    errorDescription = map["error_description"];
  }
}

class TokenResult extends BaseEntity{
  String accessToken;
  String refreshToken;
  String tokenType;
  int expiresIn;
  int uid;

  TokenResult.fromJson(String jsonString) : super.fromJson(jsonString){
    accessToken = map["access_token"];
    refreshToken = map["refresh_token"];
    tokenType = map["token_type"];
    expiresIn = map["expires_in"];
    uid = map["uid"];
  }

}
class NewsBrief{
  int id;
  String author;
  String pubDate;
  int authorid;
  String title;
  int commentCount;
  int type;
  NewsBrief.fromMap(Map<String, dynamic> map){
    id = map["id"];
    author = map["author"];
    pubDate = map["pubDate"];
    authorid = map["authorid"];
    title = map["title"];
    commentCount = map["commentCount"];
  }
}
class NewsListResult extends BaseEntity{
  List<NewsBrief> newsList;

  NewsListResult.fromJson(String jsonString) : super.fromJson(jsonString){
    var list = map["newslist"];
    if(list != null && list is List){
      newsList = list.map((map) => NewsBrief.fromMap(map)).toList();
    }
  }

}
class NewsDetail extends BaseEntity{
  int id;
  String title;
  String body;
  String pubDate;
  int authorId;
  int favorite;
  int commentCount;
  String url;
  List<RelativeNews> relativeNews;

  NewsDetail.fromJson(String jsonString) : super.fromJson(jsonString){
    id = map["id"];
    title = map["title"];
    body = map["body"];
    pubDate = map["pubDate"];
    authorId = map["authorid"];
    favorite = map["favorite"];
    commentCount = map["commentCount"];
    url = map["url"];
    var list = map["relativies"];
    if(list != null && list is List){
      relativeNews = list.map((map) => RelativeNews.fromMap(map)).toList();
    }
  }
}
class RelativeNews{
  String title;
  String url;
  RelativeNews.fromMap(Map<String, dynamic> map){
    title = map["title"];
    url = map["url"];
  }
}

class TweetBrief{
  int id;
  String pubDate;
  String body;
  String author;
  int authorId;
  int commentCount;
  String portrait;
  int type;
  TweetBrief.fromMap(Map<String, dynamic> map){
    id = map["id"];
    pubDate = map["pubDate"];
    body = map["body"];
    author = map["author"];
    commentCount = map["commentCount"];
    portrait = map["portrait"];
    type = map["type"];
  }
}

class TweetListResult extends BaseEntity{
  List<TweetBrief> tweetList;

  TweetListResult.fromJson(String jsonString) : super.fromJson(jsonString){
    var list = map["tweetlist"];
    if(list != null && list is List){
      tweetList = list.map((map) => TweetBrief.fromMap(map)).toList();
    }
  }

}

class TweetDetail extends BaseEntity{
  int id;
  String pubDate;
  String body;
  String author;
  int authorId;
  String imageSmall;
  String imageBig;
  int commentCount;
  String portrait;

  TweetDetail.fromJson(String jsonString) : super.fromJson(jsonString){
    id = map["id"];
    pubDate = map["pubDate"];
    body = map["body"];
    author = map["author"];
    authorId = map["authorid"];
    imageSmall = map["imageSmall"];
    imageBig = map["imageBig"];
    commentCount = map["commentCount"];
    portrait = map["portrait"];
  }
}
class Comment{
  int id;
  String content;
  String pubDate;
  int clientType;
  String commentAuthor;
  int commentAuthorId;
  String commentPortrait;
  List<Refer> refers;
  List<Reply> replies;

  Comment.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    content = map["content"];
    pubDate = map["pubDate"];
    clientType = map["client_type"];
    commentAuthor = map["commentAuthor"];
    commentAuthorId = map["commentAuthorId"];
    commentPortrait = map["commentPortrait"];
    var referList = map["refers"];
    if(referList != null && referList is List){
      refers = referList.map((map) => Refer.fromMap(map)).toList();
    }
    var replyList = map["replies"];
    if(replyList != null && replyList is List){
      replies = replyList.map((map) => Reply.fromMap(map)).toList();
    }
  }
}
class Refer{
  String referTitle;
  String referBody;
  Refer.fromMap(Map<String, dynamic> map){
    referTitle = map["refertitle"];
    referBody = map["referbody"];
  }
}

class Reply{
  String author;
  String pubDate;
  String authorId;
  String content;
  Reply.fromMap(Map<String, dynamic> map){
    author = map["rauthor"];
    pubDate = map["rpubDate"];
    authorId = map["rauthorId"];
    content = map["rcontent"];
  }
}

class CommentListResult extends BaseEntity{
  List<Comment> commentList;

  CommentListResult.fromJson(String jsonString) : super.fromJson(jsonString){
    var list = map["commentList"];
    if(list != null && list is List){
      commentList = list.map((map) => Comment.fromMap(map)).toList();
    }
  }

}