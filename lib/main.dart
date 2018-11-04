import 'package:flutter/material.dart';
import 'login.dart';
import 'regist.dart';
import 'page/menu_page.dart';
import 'page/my_page.dart';
import 'page/home_page.dart';



class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page',),
      routes: {
        "login":(BuildContext content) => new LoginPage(),
        "regist":(BuildContext content) => new RegistPager(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _current = 0;
  var _pageList;

  void initData(){
    _pageList = [
      new HomePage(),
      new MenuPage(),
      new MyPage(),
    ];
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    initData();
    return new Scaffold(
      body: _pageList[_current],
 // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(icon: new Icon(Icons.home), title: new Text("首页")),
        new BottomNavigationBarItem(icon: new Icon(Icons.message), title: new Text("信息")),
//        new BottomNavigationBarItem(icon: new Icon(Icons.shopping_basket), title: new Text("商城")),
        new BottomNavigationBarItem(icon: new Icon(Icons.account_box), title: new Text("我的")),
      ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _current,
        onTap: (int tab){
          print("currect:"+"$tab");
          setState(() {
            _current = tab;
          });
        },
      ),
    );
  }


}
