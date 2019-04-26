/**
 * Created by Sylva Lee
 */

const APP_ID = "你的id";
const PRIVATE_KEY = "你的key";
const REDIRECT_URL = "你的回调url";
const HOST = "https://www.oschina.net";
const OAUTH_URL = "$HOST/action/oauth2/authorize?client_id=$APP_ID&response_type=code&redirect_uri=$REDIRECT_URL" ;
const TOKEN_URL = "$HOST/action/openapi/token";
const USER_INFO_URL = "$HOST/action/openapi/user";
const NEWS_LIST_URL ="$HOST/action/openapi/news_list";
const NEWS_DETAIL_URL ="$HOST/action/openapi/news_detail";
const TWEET_LIST_URL ="$HOST/action/openapi/tweet_list";
const TWEET_DETAIL_URL ="$HOST/action/openapi/tweet_detail";
const COMMENT_LIST_URL ="$HOST/action/openapi/comment_list";

