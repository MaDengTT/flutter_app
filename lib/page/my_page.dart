import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/user.dart';
import 'package:flutter_app/data/reducers.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
class MyPage extends StatefulWidget{
  final Store<AppState> store;
  MyPage(this.store);

  @override
  _MenuPageState createState() {
    return new _MenuPageState();
  }

}

class _MenuPageState extends State<MyPage>{
  UserBean _userBean;
  String avatar;
  List<String> titles;
 
  void initData(){

  }

  Container buildImageAvatar(){
    titles = <String>["第一条","第二条","第三条","第四条","第五条","第六条","第七条","第八条","第九条","第十条"];
    return new Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          image: new DecorationImage(
              image: buildAvatar(),fit: BoxFit.cover),
          border: new Border.all(color: Colors.white,width: 2.0)
      ),
    );
  }

  ImageProvider buildAvatar(){
    if(_userBean==null||_userBean.avatar.isEmpty){
      return new AssetImage("assets/avatar.png",);
    }else{
      return new NetworkImage(_userBean.avatar);
    }
  }

  Container buildItem(String title,int index){
    return new Container(
      alignment: Alignment.centerLeft,
      child: new InkWell(
        onTap: (){
          print("the is the item of $title");
        },
        child: new Column(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.fromLTRB(15.0, 14.0, 15.0, 14.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(child: new Text(title,style: TextStyle(color: Colors.black),)),
//                  new IconButton(icon: new Icon(Icons.navigate_next), onPressed: null)
                new Image.asset("assets/next.png",width: 18.00,height: 18.00,)
                ],
              ),
            ),
            new Divider(height: 1.0,)
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: AppBar(title: new Text("我的")),
      body: new CustomScrollView(
        shrinkWrap: false,
        reverse: false,
        slivers: <Widget>[
          new SliverAppBar(
            pinned: false,
            floating: false,
            backgroundColor: Colors.blue,
            expandedHeight: 200.0,
            iconTheme: new IconThemeData(color: Colors.transparent),//隐藏标题栏
            flexibleSpace: FlexibleSpaceBar(
              background: new InkWell(
                onTap: (){
                  if(_userBean==null){
                    Navigator.pushNamed(context, "login");
                  }else{

                  }
                },
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildImageAvatar(),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: new Text("点击头像登录",
                        style: new TextStyle(color: Colors.white,fontSize: 16.0),),
                    )
                  ],
                ),
              ),
            ),

          ),
          new SliverFixedExtentList(delegate: new SliverChildBuilderDelegate((BuildContext context,int index){
            String title = titles[index];
//          return new Text("$title");
            return buildItem(title,index);
          }, childCount: titles.length),
              itemExtent: 50.0)
        ],
      ),
    );
  }
}