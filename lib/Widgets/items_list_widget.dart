import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/ListPage.dart';


class ItemsListWidget extends StatelessWidget {
  HomePage fatherWidget;
  List itemsList;
  String checkAction;
  StreamController<String> controller = StreamController.broadcast();

  ItemsListWidget(this.fatherWidget, this.itemsList, this.checkAction, this.controller);

  String formatItem(Map item) {
    if (item["company_name"] == ""){
      return "item:  " +
          item["item_name"];
    }
    return "item:  " +
        item["item_name"] +
        "     company:  " +
        item["company_name"];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (BuildContext context, int index) {
          String item_name = itemsList[index]["item_name"];
          return Dismissible(
              key: Key(item_name),
              child: Card(
                  // color: isTapped ? Colors.grey[300] : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  margin: EdgeInsets.all(4),
                  child: Container(
                    // color: ,
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: Text(
                            formatItem(itemsList[index])),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[300],
                            ),
                            onPressed: () {
                              fatherWidget.itemAction(
                                  itemsList[index], 'remove_item', controller);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              fatherWidget.itemAction(
                                  itemsList[index], checkAction, controller);
                            },
                          ),
                        ])),
                  )));
        },
      ),
    );
  }
}
