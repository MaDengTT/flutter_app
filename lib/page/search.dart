import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchWidget createState() {
    return new _SearchWidget();
  }
}

class _SearchWidget extends State<SearchPage> {
  List<DemoItem<dynamic>> _demoItems;

  @override
  void initState() {
    super.initState();

    _demoItems = <DemoItem<dynamic>>[
      DemoItem<String>(
          name: "Trip",
          value: 'Caribbean cruise',
          hint: 'Change trip name',
          valueToString: (String value) => value,
          builder: (DemoItem<String> item) {
            void close() {
              setState(() {
                item.isExpanded = false;
              });
            }

            return Form(
              child: Builder(builder: (BuildContext context) {
                return CollapsibleBody(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: item.textController,
                      decoration: InputDecoration(
                          hintText: item.hint, labelText: item.name),
                      onSaved: (String value) {
                        item.value = value;
                      },
                    ),
                  ),
                );
              }),
            );
          })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              margin: const EdgeInsets.all(24.0),
              child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _demoItems[index].isExpanded = !isExpanded;
                  });
                },
                children:
                    _demoItems.map<ExpansionPanel>((DemoItem<dynamic> item) {
                  return ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: item.headerBuilder,
                      body: item.build()
//                    body: new SizedBox(height: 100.0,)
                      );
                }).toList(),
              ),
            )),
      ),
    );
  }
}

class CollapsibleBody extends StatelessWidget {
  const CollapsibleBody(
      {Key key, this.margin, this.onSave, this.onCancel, this.child})
      : super(key: key);
  final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0) -
              margin,
          child: Center(
            child: DefaultTextStyle(
                style: textTheme.caption.copyWith(fontSize: 15.0),
                child: child),
          ),
        ),
        const Divider(
          height: 1.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                    onPressed: onCancel,
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: FlatButton(
                      onPressed: onSave,
                      textTheme: ButtonTextTheme.accent,
                      child: const Text('SAVE')))
            ],
          ),
        )
      ],
    );
  }
}

typedef DemoItemBodyBuilder<T> = Widget Function(DemoItem<T> item);
typedef ValueToString<T> = String Function(T value);

class DemoItem<T> {
  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;

  T value;
  bool isExpanded = false;

  DemoItem({this.name, this.hint, this.value, this.builder, this.valueToString})
      : textController = TextEditingController(text: valueToString(value));

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          showHint: isExpanded);
    };
  }

  Widget build() => builder(this);
}

class DualHeaderWithHint extends StatelessWidget {
  final String name;
  final String value;
  final String hint;
  final bool showHint;

  const DualHeaderWithHint({this.name, this.value, this.hint, this.showHint});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: textTheme.body1.copyWith(fontSize: 15.0),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: _crossFade(
                Text(
                  value,
                  style: textTheme.caption.copyWith(fontSize: 15.0),
                ),
                Text(
                  hint,
                  style: textTheme.caption.copyWith(fontSize: 15.0),
                ),
                showHint),
          ),
        )
      ],
    );
  }

  _crossFade(Widget first, Widget second, bool isExpanded) {
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
}
