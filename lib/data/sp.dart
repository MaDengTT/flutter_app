import 'package:shared_preferences/shared_preferences.dart';


setUserAuth(bool isLogin,int userId) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setBool('is_login',isLogin);
  if(isLogin){
    await preferences.setInt("user_id", userId);
  }else{
    await preferences.remove("user_id");
  }

}

Future<int> getUserId() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("user_id");
}
Future<bool> isLogin() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getBool("is_login");
}