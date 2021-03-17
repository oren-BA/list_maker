import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/Pages/MainPage.dart';
import 'package:list_maker/Widgets/add_list_widget.dart';
import 'package:list_maker/Widgets/clickable_avatar_widget.dart';

class NoListWidget extends StatelessWidget {

  var user;
  var provider;
  String title;
  MyHomePage homePage;
  var fatherWidget;

  NoListWidget(this.user, this.provider, this.title, this.homePage, this.fatherWidget);


  void refreshLists() async {
    fatherWidget.refreshLists();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          // centerTitle: true,
          actions: [ClickableAvatarWidget(user, provider, homePage)],
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
                  children: <Widget>[Text('click here to add or join lists')])
            ],
          ),
        ),
        floatingActionButton: AddListWidget(user, homePage, this));
  }
}