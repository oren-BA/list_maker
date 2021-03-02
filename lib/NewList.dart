import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewList extends StatefulWidget{
  HomePage createState()=> HomePage();
}


class HomePage extends State<NewList>{
  List<String> items = ["milk"];
  String input = "";

  // @override
  // void initState(){
  //   super.initState();
  //   items.add("item1");
  // }

  void addItem(String input){
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      items.add(input);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your list"),
      ),
      body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: Key(items[index]),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      elevation: 4,
                      margin: EdgeInsets.all(4),
                      child: ListTile(
                          title: Text(items[index]),
                          trailing:
                            IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              onPressed: () {
                                  setState(() {
                                    items.removeAt(index);
                                  });
                              },
                            )
                      )
                  )
              );
            },
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("add item"),
                content: TextField(
                  onChanged: (String itemName){
                    input = itemName;
              },
              ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      addItem(input);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"))
                ],
              );
            }
          );
          },
    tooltip: 'Increment',
    child: Icon(Icons.add),
    ));
  }
}