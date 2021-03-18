import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_maker/Pages/MainPage.dart';
import 'package:list_maker/Widgets/error_message_widget.dart';
import 'package:list_maker/config.dart';

class AddListWidget extends StatefulWidget {
  String inputList = CONFIG.empty_string;
  var user;
  MyHomePage homePage;
  var fatherWidget;
  StreamController<String> controller = StreamController.broadcast();

  AddListWidget(this.user, this.homePage, this.fatherWidget);

  @override
  _AddListWidgetState createState() => _AddListWidgetState();
}

class _AddListWidgetState extends State<AddListWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != CONFIG.empty_string) {
              return ErrorMessageWidget(snapshot.data, widget.controller);
          }
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      title: Text(CONFIG.add_list_widget_title),
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
                              widget.homePage.addList(widget.user,
                                  widget.inputList, widget.controller);
                              widget.inputList = CONFIG.empty_string;
                              Navigator.of(context).pop();
                            },
                            child: Text("Add"))
                      ],
                    );
                  });
            },
            child: Icon(Icons.add),
          );
        });
  }
}
