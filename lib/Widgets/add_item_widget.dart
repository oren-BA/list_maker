import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/ListPage.dart';
import 'package:list_maker/config.dart';

import 'error_message_widget.dart';

class AddItemWidget extends StatelessWidget {
  HomePage fatherWidget;
  String inputItem = CONFIG.empty_string;
  String inputCompany = CONFIG.empty_string;
  StreamController<String> controller = StreamController.broadcast();

  AddItemWidget(this.fatherWidget, this.controller);

  Map buildItem(String itemName, String companyName) {
    return {CONFIG.item_name: itemName, CONFIG.company_name: companyName};
  }

  void addItemButton(BuildContext context) {
    fatherWidget.itemAction(buildItem(inputItem, inputCompany), CONFIG.add_item, controller);
    inputItem = CONFIG.empty_string;
    inputCompany = CONFIG.empty_string;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != CONFIG.empty_string) {
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
                      title: Text(CONFIG.add_item_widget_title),
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
