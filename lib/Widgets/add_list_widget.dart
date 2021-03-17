import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/MainPage.dart';

class AddListWidget extends StatefulWidget {
  String inputList = "";
  var user;
  MyHomePage homePage;
  var fatherWidget;

  AddListWidget(this.user, this.homePage, this.fatherWidget);

  @override
  _AddListWidgetState createState() => _AddListWidgetState();
}

class _AddListWidgetState extends State<AddListWidget>{

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
                      decoration: InputDecoration(labelText: 'List name'),
                      onChanged: (String listName) {
                        widget.inputList = listName;
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        widget.homePage.addList(widget.user, widget.inputList);
                        widget.inputList = "";
                        // widget.fatherWidget.refreshLists();
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"))
                ],
              );
            });
        // getToken(user);
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
