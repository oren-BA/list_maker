import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/NewList.dart';

class AddItemWidget extends StatelessWidget {
  HomePage fatherWidget;
  String inputItem = "";
  String inputCompany = "";

  AddItemWidget(this.fatherWidget);

  Map buildItem(String item_name, String company_name) {
    return {"item_name": item_name, "company_name": company_name};
  }

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
                      decoration: InputDecoration(labelText: 'Company name'),
                      onChanged: (String companyName) {
                        inputCompany = companyName;
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        fatherWidget.itemAction(
                            buildItem(inputItem, inputCompany), 'add_item');
                        inputItem = "";
                        inputCompany = "";
                        Navigator.of(context).pop();
                      },
                      child: Text("Add"))
                ],
              );
            });
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
