import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:list_maker/API/api_requests.dart';
import 'package:list_maker/Widgets/add_item_widget.dart';
import 'package:list_maker/Widgets/items_list_widget.dart';
import 'package:list_maker/config.dart';

class NewList extends StatefulWidget {
  final user;
  String list_name = CONFIG.empty_string;
  List uncheckedItems = [];
  List checkedItems = [];
  StreamController<String> controller = StreamController.broadcast();

  NewList(this.user, this.list_name, this.uncheckedItems, this.checkedItems);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<NewList> with AutomaticKeepAliveClientMixin {
  String inputItem = CONFIG.empty_string;
  String inputCompany = CONFIG.empty_string;
  String item;
  bool tapped;

  void itemAction(
      Map item, String action, StreamController<String> errorController) async {
    final idToken = await widget.user.getIdToken(true);
    Response response = await itemActionAPI(idToken, action, widget.list_name,
        item[CONFIG.item_name], item[CONFIG.company_name]);
    if (response.body[0] != "{") {
      errorController.add(response.body);
      return;
    }
    Map userList = json.decode(response.body);
    widget.checkedItems = userList[CONFIG.checked_items];
    widget.uncheckedItems = userList[CONFIG.unchecked_items];
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
          ItemsListWidget(this, widget.uncheckedItems, 'check_item', widget.controller),
          Divider(
            thickness: 5,
            indent: 15,
            endIndent: 15,
          ),
          ItemsListWidget(this, widget.checkedItems, 'uncheck_item', widget.controller),
        ]),
        floatingActionButton: AddItemWidget(this, widget.controller));
  }

  @override
  bool get wantKeepAlive => true;
}
