import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:list_maker/API/api_requests.dart';
import 'package:list_maker/Widgets/add_item_widget.dart';
import 'package:list_maker/Widgets/items_list_widget.dart';

class NewList extends StatefulWidget {
  final user;
  String list_name = "";
  List uncheckedItems = [];
  List checkedItems = [];

  NewList(this.user, this.list_name, this.uncheckedItems,
      this.checkedItems); // NewList({Key key, this.name}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<NewList> with AutomaticKeepAliveClientMixin {
  String inputItem = "";
  String inputCompany = "";
  String item;
  bool tapped;

  void itemAction(Map item, String action) async {
    final idToken = await widget.user.getIdToken(true);
    Response response = await itemActionAPI(idToken, action, widget.list_name,
        item["item_name"], item["company_name"]);
    //TODO: make error message
    Map userList = json.decode(response.body);
    widget.checkedItems = userList["checkedItems"];
    widget.uncheckedItems = userList["uncheckedItems"];
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.list_name),
        ),
        body: Column(children: [
          ItemsListWidget(this, widget.uncheckedItems, 'check_item'),
          Divider(
            thickness: 5,
            indent: 15,
            endIndent: 15,
          ),
          ItemsListWidget(this, widget.checkedItems, 'uncheck_item'),
        ]),
        floatingActionButton: AddItemWidget(this));
  }

  @override
  bool get wantKeepAlive => true;
}
