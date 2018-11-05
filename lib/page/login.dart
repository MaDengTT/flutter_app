import 'package:flutter/material.dart';
import 'package:flutter_app/bean/user.dart';
import 'package:flutter_app/im_app.dart';
import 'package:flutter_app/data/api.dart' as api;
import 'dart:convert' show json;
typedef Future CallLogin(UserBean bean);
class LoginPage extends StatefulWidget{

  final CallLogin callLogin;


  LoginPage({this.callLogin});

  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage>{
  String _password;
  String _account;

  bool _isObscure = false;
  var _eyeColor = Colors.grey;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("LoginPage"),
      ),
      body:Form(
          key: _formKey,
          child: buildList()),
    );
  }

  ListView buildList() {
    return new ListView(
      padding: EdgeInsets.symmetric(horizontal: 22.0),
      children: <Widget>[
        new SizedBox(height: 20.0,),
        buildTextLogin(),
        buildLoginLine(),
        SizedBox(height: 70.0,),
        buildTextFormUserName(),
        SizedBox(height: 30.0,),
        buildTextFormPassword(),
        SizedBox(height: 60.0,),
        buildLoginButton()
      ],
    );
  }

  Align buildLoginButton() {
    return new Align(
        child: SizedBox(height: 45.0,width: 270.0,
        child: RaisedButton(onPressed: (){
          if(_formKey.currentState.validate()){
            _formKey.currentState.save();
            api.login(null,_account, _password).then((value){
              print(value);
              Map<String,dynamic> bean = json.decode(value.data);
              if(bean['code'] == 200){
                var decode = bean['data'];
//                Map<String,dynamic> decode = json.decode(bean['data']);
                var userBean = UserBean.fromJson(decode);
                widget.callLogin(userBean);
              }
            });
          }
        },child: Text("登录",style: Theme.of(context).primaryTextTheme.headline,),
        color: Colors.blue,
          shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
        ),
        ),
      );
  }

  TextFormField buildTextFormPassword() {
    return new TextFormField(
        onSaved: (String value) => _password = value,
        obscureText: _isObscure,
        validator: (String value){
          if(value.isEmpty) {
            return '请输入密码';
          }
        },
        decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(icon:Icon(Icons.remove_red_eye,color:_eyeColor),
              onPressed: (){
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure?
                      Colors.grey
                      :Colors.blue;
                });
          })
        ),
      );
  }
  TextFormField buildTextFormUserName() {
    return new TextFormField(
        onSaved: (String value) => _account = value,
        validator: (String value){
          var emailReg = RegExp(
              r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
          if(value.isEmpty) {
            return '请输入邮箱或者手机号';
          }else if(!emailReg.hasMatch(value)){

          }
        },
        decoration: InputDecoration(
          labelText: 'Email And Phone',
        ),
      );
  }

  Padding buildLoginLine() {
    return new Padding(padding: EdgeInsets.only(left: 12.0,top: 4.0),
      child: Align(alignment: Alignment.bottomLeft,child: Container(color: Colors.blue,width: 40.0,height: 2.0,),),);
  }

  Padding buildTextLogin(){
    return Padding(padding: EdgeInsets.all(8.0),
        child: new Text("Login",
          style:new TextStyle(fontSize: 42.00,color: Colors.blue),));
  } 
  
  Container buildContainer(BuildContext context){
    return buildTest(context);
  }

  Container buildTest(BuildContext context) {
    return new Container(
    constraints: new BoxConstraints.expand(
      height: Theme.of(context).textTheme.display1.fontSize*1.1+200.0
    ),
    padding: const EdgeInsets.all(8.0),
    color: Colors.teal.shade700,
    alignment: Alignment.center,
    child: Column(
      children: <Widget>[
        new Text("Hello World",style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white),),
        new RaisedButton(onPressed: (){
          Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("Hello")));
        },child: new Text("Show SnackBar"),),
      ],
    ),
    foregroundDecoration: new BoxDecoration(
      image: new DecorationImage(image: new NetworkImage("https://ss0.baidu.com/73F1bjeh1BF3odCf/it/u=3824467233,582662185&fm=85&s=7021945702434EE6469DBCB903005015"),
//        centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0)
      )
    ),
    transform: new Matrix4.rotationZ(0.1),
  );
  }
}