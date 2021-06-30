import 'package:flutter/cupertino.dart';
import '../common/constants/constants.dart';

class IOSApp extends StatelessWidget {
  // This widget is the root of android platform application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: APP_TITLE,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: HOME_TITLE),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            CupertinoButton(
              child: Icon(
                CupertinoIcons.add,
                size: 50,
              ),
              onPressed: _incrementCounter,
            ),
          ],
        ),
      ),
    );
  }
}
