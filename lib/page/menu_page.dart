import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget{
  @override
  _MenuPageState createState() {
    return new _MenuPageState();
  }

}

class _MenuPageState extends State<MenuPage>{
  Widget buildListTitle(BuildContext context,String item){
    return Container(
//      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 0.0),
        child: new Card(
          elevation: 1.0,
          child: Column(
            children: <Widget>[
              AspectRatio(
                  aspectRatio:2/1,
                  child: Image.network(
                      "https://cdn2.jianshu.io/assets/web/web-note-ad-1-c2e1746859dbf03abe49248893c9bea4.png",
                    fit:BoxFit.cover,
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150.0,right: 16.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.centerLeft,
                      child: new Text("Item Name",style: new TextStyle(fontSize: 20.0,color: Colors.black),),
                    ),
                    new Stack(
                      children: <Widget>[
                        new Align(
                          child: new Text("价格"),
                          alignment: FractionalOffset.centerLeft,
                        ),
                        new Align(
                          alignment: FractionalOffset.centerRight,
                          child: new Text("20.0"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = <String>['A','B','B','B','B','B','B','B','B','B','B','B','B','B'];
     Iterable<Widget> list= items.map((String item){
      return buildListTitle(context, item);
    });
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: new AppBar(title: new Text("MenuPage"),),
      body: new Scrollbar(
          child: new ListView(
        children: list.toList(),
      )),
    );
  }

}