/**
 * Created by Sylva Lee
 */

import 'package:sylvan_osc/entity/entity.dart';
class AppState{
  User user;
  TokenResult tokenResult;

  AppState({this.user, this.tokenResult});
  AppState.empty();
}
User userReducer(User user, action){
  if(action is UserUpdateAction){
    user = action.user;
  }
  return user;
}
TokenResult tokenReducer(TokenResult tokenResult, action){
  if(action is TokenUpdateAction){
    tokenResult = action.tokenResult;
  }
  return tokenResult;
}
AppState appReducer(AppState appState, action){
  return AppState(
    user: userReducer(appState.user, action),
    tokenResult: tokenReducer(appState.tokenResult, action)
  );
}

class UserUpdateAction{
  User user;
  UserUpdateAction(this.user);
}
class TokenUpdateAction{
  TokenResult tokenResult;
  TokenUpdateAction(this.tokenResult);
}

