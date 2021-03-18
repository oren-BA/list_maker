import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/ListPage.dart';

import 'error_message_widget.dart';

class AddItemWidget extends StatelessWidget {
  HomePage fatherWidget;
  String inputItem = "";
  String inputCompany = "";
  StreamController<String> controller = StreamController.broadcast();

  AddItemWidget(this.fatherWidget, this.controller);

  Map buildItem(String itemName, String companyName) {
    return {"item_name": itemName, "company_name": companyName};
  }

  void addItemButton(BuildContext context) {
    fatherWidget.itemAction(buildItem(inputItem, inputCompany), 'add_item', controller);
    inputItem = "";
    inputCompany = "";
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != "") {
            return ErrorMessageWidget(snapshot.data, controller);
          }
          return FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      title: Text("add item"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Item name'),
                            onChanged: (String itemName) {
                              inputItem = itemName;
                            },
                          ),
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Company name'),
                            onChanged: (String companyName) {
                              inputCompany = companyName;
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              addItemButton(context);
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
