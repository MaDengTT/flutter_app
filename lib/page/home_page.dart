import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/plugins_test.dart';
class HomePage extends StatefulWidget{


  @override
  _HomePageState createState() {
    return new _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{
  var _counter = 0;

  var _image;

  int level;

  _getBatterLevel(){
    getBatteryLevel().then((value){
      setState(() {
        level = value;
      });
    });
  }

  @override
  void initState(){
    print("initState ==> home_page");
    super.initState();
    registerAndroidStream((value){
      _incrementCounter(value);
    }, (error)=>{});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter(value) {
    if(this.mounted) {
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        _counter=value;
      });
    }

  }

  void getImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery,);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: new Text("Home"),),
      body: buildCenter(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
  Center buildCenter(BuildContext context) {
    return new Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: new Column(
        // Column is also layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug paint" (press "p" in the console where you ran
        // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
        // window in IntelliJ) to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 100,height: 100,
          child: _image == null?new Text("No image"):
            new Image.file(_image,fit: BoxFit.fill,),
          ),
          new Text(
            '当前电量为 $level',
          ),
          new Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
          new FlatButton(onPressed: (){
            Navigator.pushNamed(context, "login");
          }, child: new Text("To Login")),
          new FlatButton(onPressed: (){
            Navigator.pushNamed(context, "search");
          }, child: new Text("To Search")),
          new FlatButton(onPressed: (){
            _getBatterLevel();
          }, child: new Text("getLevel")),
        ],
      ),
    );
  }
}