class UserBean {
  int userId;
  String avatar;
  String userName;
  String userInfo;
  String phone;

  UserBean.fromJson(Map<String,dynamic> json):userName = json['userName']
  ,userId=json['userID'],avatar=json['avatar'],phone=json['phone'];

}