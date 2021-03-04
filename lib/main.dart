import 'package:flutter/material.dart';

import 'NewList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List maker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'List maker'),
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List lists = [];
  String inputList = "";
  Map<String,NewList> listPages = {};

  void addList(String inputList) {
    setState(() {
      if (inputList == "") {
        return;
      }
      lists.add(inputList);
      listPages[inputList] = NewList(name: inputList);
    });
  }


  @override
  Widget build(BuildContext context) {
    return lists.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You dont have any lists',
                    style: new TextStyle(
                      fontSize: 25.0,
                      // color: Colors.red
                    ),
                  ),
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('click here to add or join lists')
                      ])
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Text("add List"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'List name'),
                              onChanged: (String listName) {
                                inputList = listName;
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                addList(inputList);
                                inputList = "";
                                Navigator.of(context).pop();
                              },
                              child: Text("Add"))
                        ],
                      );
                    });
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ))
        : Scaffold(
            appBar: AppBar(
              title: Text("Your lists"),
            ),
            body: ListView.builder(
              itemCount: lists.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(lists[index]),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        margin: EdgeInsets.all(4),
                        child: ListTile(
                          title: Text(lists[index]),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                lists.removeAt(index);
                              });
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => listPages[lists[index]]),
                            );
                          },
                        )));
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Text("add List"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'List name'),
                              onChanged: (String listName) {
                                inputList = listName;
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                addList(inputList);
                                inputList = "";
                                Navigator.of(context).pop();
                              },
                              child: Text("Add"))
                        ],
                      );
                    });
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ));
  }
}
