import 'package:flutter/material.dart';

class MyPage extends StatefulWidget{
  @override
  _MenuPageState createState() {
    return new _MenuPageState();
  }

}

class _MenuPageState extends State<MyPage>{
  String avatar;
  List<String> titles;

  Container buildImageAvatar(){
    titles = <String>["第一条","第二条","第三条","第四条","第五条","第六条","第七条","第八条","第九条","第十条"];
    return new Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          image: new DecorationImage(
//            if(avatar == null||avatar.isEnemy)
              image: new NetworkImage("https://www.csdn.net/app/img/wxfix.png"),fit: BoxFit.cover),
          border: new Border.all(color: Colors.white,width: 2.0)
      ),
    );
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
            new Padding(padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(child: new Text(title,style: TextStyle(color: Colors.black),)),
//                  new IconButton(icon: new Icon(Icons.navigate_next), onPressed: null)
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